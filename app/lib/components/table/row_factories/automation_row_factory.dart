import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../dialogs/delete_automation_dialog.dart';
import '../../../dialogs/edit_automation_dialog.dart';
import '../../../extensions/nullable_ext.dart';
import '../../../models/automation.dart';
import '../../../models/device.dart';
import '../../../services/automation_service.dart';
import '../../../services/device_service.dart';
import '../../../util/singleton_registry.dart';
import 'row_factory.dart';

class AutomationRowFactory extends RowFactory<Automation> {
  final Stream<Device?> _activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final AutomationService _automationService = SingletonRegistry.get();

  @override
  DataRow create(BuildContext context, Automation data) {
    return DataRow(cells: [
      DataCell(Text(data.name)),
      DataCell(OverflowBar(
        children: [
          StreamBuilder(
            stream: _activeDevice,
            builder: (context, snapshot) => IconButton(
              onPressed: snapshot.data?.let(
                (activeDevice) =>
                    () => _automationService.run(context, activeDevice, data),
              ),
              icon: const Icon(Icons.play_arrow),
              tooltip: AppLocalizations.of(context)!.buttonRun,
            ),
          ),
          IconButton(
            onPressed: () => EditAutomationDialog.show(context, data),
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.buttonEdit,
          ),
          IconButton(
            onPressed: () {
              Automation copy = Automation()
                ..name =
                    '${data.name} - ${AppLocalizations.of(context)!.copyNamePostfix}'
                ..commands = data.commands;
              _automationService.put(copy);
            },
            icon: const Icon(Icons.copy),
            tooltip: AppLocalizations.of(context)!.buttonDuplicate,
          ),
          IconButton(
            onPressed: () => DeleteAutomationDialog.show(context, data),
            icon: const Icon(Icons.delete),
            tooltip: AppLocalizations.of(context)!.buttonDelete,
          ),
        ],
      )),
    ]);
  }
}
