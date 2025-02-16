import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../constants/routes.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  static final List<String> _menuRoutes = [
    Routes.connections,
    Routes.emulators,
    Routes.keyboard,
    Routes.remoteControl,
    Routes.install,
    Routes.automations,
    Routes.proxies,
    Routes.screenshot,
    Routes.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                context.go(_menuRoutes[index]);
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.devices),
                  label:
                      Text(AppLocalizations.of(context)!.pageTitleConnections),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.android),
                  label: Text(AppLocalizations.of(context)!.pageTitleEmulators),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.keyboard),
                  label: Text(AppLocalizations.of(context)!.pageTitleKeyboard),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_remote),
                  label: Text(
                      AppLocalizations.of(context)!.pageTitleRemoteControl),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.install_mobile),
                  label: Text(AppLocalizations.of(context)!.pageTitleInstall),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.auto_mode),
                  label:
                      Text(AppLocalizations.of(context)!.pageTitleAutomations),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.compare_arrows),
                  label: Text(AppLocalizations.of(context)!.pageTitleProxies),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.screenshot),
                  label:
                      Text(AppLocalizations.of(context)!.pageTitleScreenshot),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(AppLocalizations.of(context)!.pageTitleSettings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
