import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/automation/argument_input.dart';
import '../components/automation/command_selector.dart';
import '../components/automation/operation_selector.dart';
import '../components/dialog_container.dart';
import '../constants/automations.dart';
import '../models/automation.dart';
import '../services/automation_service.dart';
import '../util/singleton_registry.dart';
import '../util/validator.dart';

class EditAutomationDialog extends StatefulWidget {
  final Automation? automation;

  const EditAutomationDialog({super.key, this.automation});

  static void show(BuildContext context, Automation? automation) {
    showDialog(
      context: context,
      builder: (_) => EditAutomationDialog(automation: automation),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditAutomationDialogState();
}

class _EditAutomationDialogState extends State<EditAutomationDialog> {
  final AutomationService _service = SingletonRegistry.get();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  late List<Command> _commands;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.automation?.name ?? '';
    _commands = widget.automation?.commands.toList() ??
        [Automations.getCommand(CommandType.values.first)];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.automation?.id;
    final title = id == null
        ? AppLocalizations.of(context)!.dialogTitleAutomationAdd
        : AppLocalizations.of(context)!.dialogTitleAutomationEdit;
    final saveButtonLabel = id == null
        ? AppLocalizations.of(context)!.buttonAdd
        : AppLocalizations.of(context)!.buttonSave;
    return DialogContainer(
      title: title,
      confirmLabel: saveButtonLabel,
      confirmAction: () => _onSave(id, context),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.fieldName,
              ),
              validator: (value) => Validator.validateName(value, context),
              autofocus: true,
            ),
            const SizedBox(height: 10.0),
            ..._commands.mapIndexed(
              (index, command) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Command #${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          OverflowBar(children: [
                            IconButton(
                              onPressed: index > 0
                                  ? () => setState(() {
                                        final Command temp = _commands[index];
                                        _commands[index] = _commands[index - 1];
                                        _commands[index - 1] = temp;
                                      })
                                  : null,
                              icon: const Icon(Icons.move_up),
                              tooltip:
                                  AppLocalizations.of(context)!.buttonMoveUp,
                            ),
                            IconButton(
                              onPressed: index < _commands.length - 1
                                  ? () => setState(() {
                                        final Command temp = _commands[index];
                                        _commands[index] = _commands[index + 1];
                                        _commands[index + 1] = temp;
                                      })
                                  : null,
                              icon: const Icon(Icons.move_down),
                              tooltip:
                                  AppLocalizations.of(context)!.buttonMoveDown,
                            ),
                            IconButton(
                              onPressed: () => setState(() {
                                Operation operationCopy = Operation()
                                  ..type = command.operation.type
                                  ..arguments = command.operation.arguments
                                      .map(
                                        (argument) => Argument()
                                          ..type = argument.type
                                          ..inputType = argument.inputType
                                          ..value = argument.value,
                                      )
                                      .toList();
                                Command commandCopy = Command()
                                  ..type = command.type
                                  ..operation = operationCopy;
                                _commands.insert(index + 1, commandCopy);
                              }),
                              icon: const Icon(Icons.copy),
                              tooltip:
                                  AppLocalizations.of(context)!.buttonDuplicate,
                            ),
                            IconButton(
                              onPressed: _commands.length > 1
                                  ? () => setState(() {
                                        _commands.removeAt(index);
                                      })
                                  : null,
                              icon: const Icon(Icons.delete),
                              tooltip:
                                  AppLocalizations.of(context)!.buttonDelete,
                            ),
                          ])
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      CommandSelector(
                        command: command,
                        onChanged: (value) => setState(() {
                          _commands[index] = value;
                        }),
                      ),
                      const SizedBox(height: 10.0),
                      OperationSelector(
                        command: command,
                        onChanged: (value) => setState(() {
                          command.operation = value;
                        }),
                      ),
                      ...command.operation.arguments
                          .where(
                            (argument) => argument.type != ArgumentType.static,
                          )
                          .map(
                            (argument) => [
                              const SizedBox(height: 10.0),
                              ArgumentInput(
                                argument: argument,
                                onValueChanged: (value) => setState(() {
                                  argument.value = value;
                                }),
                              ),
                            ],
                          )
                          .flattened,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: IconButton(
                onPressed: () => setState(() {
                  _commands.add(
                    Automations.getCommand(CommandType.values.first),
                  );
                }),
                icon: const Icon(Icons.add),
                tooltip: AppLocalizations.of(context)!.buttonAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(int? id, BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      var automation = Automation()
        ..name = _nameController.text
        ..commands = _commands;
      if (id != null) {
        automation.id = id;
      }
      await _service.put(automation);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
