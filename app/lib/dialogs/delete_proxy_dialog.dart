import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../models/proxy.dart';
import '../services/proxy_service.dart';
import '../util/singleton_registry.dart';

class DeleteProxyDialog extends StatelessWidget {
  final ProxyService _service = SingletonRegistry.get();

  final Proxy proxy;

  DeleteProxyDialog({super.key, required this.proxy});

  static void show(BuildContext context, Proxy proxy) {
    showDialog(
      context: context,
      builder: (_) => DeleteProxyDialog(proxy: proxy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: AppLocalizations.of(context)!.dialogTitleProxyDelete,
      confirmLabel: AppLocalizations.of(context)!.buttonDelete,
      confirmAction: () => _onDelete(context),
      child: Text(
        AppLocalizations.of(context)!
            .dialogMessageConfirmDelete(proxy.toString()),
      ),
    );
  }

  void _onDelete(BuildContext context) async {
    await _service.delete(proxy);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
