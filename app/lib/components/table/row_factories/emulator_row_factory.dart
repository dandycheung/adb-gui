import 'package:app/dialogs/edit_emulator_params_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/emulator.dart';
import '../../../services/emulator_service.dart';
import '../../../util/singleton_registry.dart';
import 'row_factory.dart';

class EmulatorRowFactory extends RowFactory<Emulator> {
  final EmulatorService _emulatorService = SingletonRegistry.get();

  @override
  DataRow create(BuildContext context, Emulator data) {
    return DataRow(cells: [
      DataCell(Text(data.name)),
      DataCell(OverflowBar(
        children: [
          IconButton(
            onPressed: () => _emulatorService.start(context, data),
            icon: const Icon(Icons.play_arrow),
            tooltip: AppLocalizations.of(context)!.buttonRun,
          ),
          IconButton(
            onPressed: () => EditEmulatorParamsDialog.show(context, data),
            icon: const Icon(Icons.settings),
            tooltip: AppLocalizations.of(context)!.buttonEditParameters,
          ),
        ],
      )),
    ]);
  }
}
