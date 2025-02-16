import 'package:app/models/emulator.dart';
import 'package:app/services/emulator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../components/toggle.dart';
import '../util/singleton_registry.dart';

class EditEmulatorParamsDialog extends StatefulWidget {
  final Emulator emulator;

  const EditEmulatorParamsDialog({super.key, required this.emulator});

  static void show(BuildContext context, Emulator emulator) {
    showDialog(
      context: context,
      builder: (_) => EditEmulatorParamsDialog(emulator: emulator),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditEmulatorParamsDialogState();
}

class _EditEmulatorParamsDialogState extends State<EditEmulatorParamsDialog> {
  final EmulatorService _service = SingletonRegistry.get();

  late bool _noSnapshotLoad;
  late bool _writeableSystem;

  @override
  void initState() {
    super.initState();
    _noSnapshotLoad = widget.emulator.params.noSnapshotLoad;
    _writeableSystem = widget.emulator.params.writeableSystem;
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: AppLocalizations.of(context)!.dialogTitleEmulatorParamsEdit,
      confirmLabel: AppLocalizations.of(context)!.buttonSave,
      confirmAction: () => _onSave(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Toggle(
            label: AppLocalizations.of(context)!.fieldNoSnapshotLoad,
            value: _noSnapshotLoad,
            onChanged: (value) => setState(() {
              _noSnapshotLoad = value;
            }),
          ),
          const SizedBox(height: 10.0),
          Toggle(
            label: AppLocalizations.of(context)!.fieldWriteableSystem,
            value: _writeableSystem,
            onChanged: (value) => setState(() {
              _writeableSystem = value;
            }),
          ),
        ],
      ),
    );
  }

  void _onSave(BuildContext context) async {
    final params = EmulatorParams()
      ..noSnapshotLoad = _noSnapshotLoad
      ..writeableSystem = _writeableSystem;
    final emulator = Emulator()
      ..id = widget.emulator.id
      ..name = widget.emulator.name
      ..params = params;
    await _service.put(emulator);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
