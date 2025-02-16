import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'device_refresh_button.dart';
import 'device_selector.dart';
import 'menu.dart';

class AppShell extends StatelessWidget {
  final Widget body;

  const AppShell({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [const DeviceSelector(), DeviceRefreshButton()],
      ),
      body: Row(
        children: [
          const Menu(),
          const VerticalDivider(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
