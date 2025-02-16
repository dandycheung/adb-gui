import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../components/table/row_factories/emulator_row_factory.dart';
import '../components/table/table_wrapper.dart';
import '../models/emulator.dart';
import '../services/emulator_service.dart';
import '../util/singleton_registry.dart';

class EmulatorsPage extends StatelessWidget {
  final EmulatorService _emulatorService = SingletonRegistry.get();
  final EmulatorRowFactory _rowFactory = EmulatorRowFactory();
  late final Stream<List<Emulator>> _emulators = _emulatorService.getAll();

  EmulatorsPage({super.key}) {
    _emulatorService.loadEmulators();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleEmulators,
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: _emulators,
          builder: (context, snapshot) => TableWrapper(
            columnNames: [
              AppLocalizations.of(context)!.fieldName,
              AppLocalizations.of(context)!.fieldActions,
            ],
            rowFactory: _rowFactory,
            items: snapshot.data ?? [],
          ),
        ),
      ),
    );
  }
}
