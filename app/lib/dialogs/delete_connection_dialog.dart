import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../models/connection.dart';
import '../services/connection_service.dart';
import '../util/singleton_registry.dart';

class DeleteConnectionDialog extends StatelessWidget {
  final ConnectionService _service = SingletonRegistry.get();

  final Connection connection;

  DeleteConnectionDialog({super.key, required this.connection});

  static void show(BuildContext context, Connection connection) {
    showDialog(
      context: context,
      builder: (_) => DeleteConnectionDialog(connection: connection),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: AppLocalizations.of(context)!.dialogTitleConnectionDelete,
      confirmLabel: AppLocalizations.of(context)!.buttonDelete,
      confirmAction: () => _onDelete(context),
      child: Text(
        AppLocalizations.of(context)!
            .dialogMessageConfirmDelete(connection.name),
      ),
    );
  }

  void _onDelete(BuildContext context) async {
    await _service.delete(connection);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
