import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../models/connection.dart';
import '../services/connection_service.dart';
import '../util/singleton_registry.dart';
import '../util/validator.dart';

class EditConnectionDialog extends StatefulWidget {
  final Connection? connection;

  const EditConnectionDialog({super.key, this.connection});

  static void show(BuildContext context, Connection? connection) {
    showDialog(
      context: context,
      builder: (_) => EditConnectionDialog(connection: connection),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditConnectionDialogState();
}

class _EditConnectionDialogState extends State<EditConnectionDialog> {
  final ConnectionService _service = SingletonRegistry.get();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.connection?.address ?? '';
    _nameController.text = widget.connection?.name ?? '';
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.connection?.id;
    final title = id == null
        ? AppLocalizations.of(context)!.dialogTitleConnectionAdd
        : AppLocalizations.of(context)!.dialogTitleConnectionEdit;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.fieldName,
              ),
              validator: (value) => Validator.validateName(value, context),
              textInputAction: TextInputAction.next,
              autofocus: true,
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.fieldAddress,
              ),
              validator: (value) => Validator.validateAddress(value, context),
              onFieldSubmitted: (value) {
                _onSave(id, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(int? id, BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      var connection = Connection()
        ..name = _nameController.text
        ..address = _addressController.text;
      if (id != null) {
        connection.id = id;
      }
      await _service.put(connection);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
