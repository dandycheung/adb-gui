import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../components/table/row_factories/automation_row_factory.dart';
import '../components/table/table_wrapper.dart';
import '../dialogs/edit_automation_dialog.dart';
import '../models/automation.dart';
import '../services/automation_service.dart';
import '../util/singleton_registry.dart';

class AutomationsPage extends StatefulWidget {
  const AutomationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AutomationsPageState();
}

class _AutomationsPageState extends State<AutomationsPage> {
  final AutomationService _automationService = SingletonRegistry.get();
  final AutomationRowFactory _rowFactory = AutomationRowFactory();
  late final Stream<List<Automation>> _automations =
      _automationService.getAll();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleAutomations,
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditAutomationDialog.show(context, null),
        tooltip: AppLocalizations.of(context)!.buttonAdd,
        child: const Icon(Icons.add),
      ),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: _automations,
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
