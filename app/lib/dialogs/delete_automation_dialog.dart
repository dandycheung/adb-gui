import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../models/automation.dart';
import '../services/automation_service.dart';
import '../util/singleton_registry.dart';

class DeleteAutomationDialog extends StatelessWidget {
  final AutomationService _service = SingletonRegistry.get();

  final Automation automation;

  DeleteAutomationDialog({super.key, required this.automation});

  static void show(BuildContext context, Automation automation) {
    showDialog(
      context: context,
      builder: (_) => DeleteAutomationDialog(automation: automation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: AppLocalizations.of(context)!.dialogTitleAutomationDelete,
      confirmLabel: AppLocalizations.of(context)!.buttonDelete,
      confirmAction: () => _onDelete(context),
      child: Text(
        AppLocalizations.of(context)!
            .dialogMessageConfirmDelete(automation.name),
      ),
    );
  }

  void _onDelete(BuildContext context) async {
    await _service.delete(automation);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
