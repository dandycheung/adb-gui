import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'components/app_shell.dart';
import 'constants/routes.dart';
import 'pages/automations_page.dart';
import 'pages/connections_page.dart';
import 'pages/emulators_page.dart';
import 'pages/install_page.dart';
import 'pages/keyboard_page.dart';
import 'pages/proxies_page.dart';
import 'pages/remote_control_page.dart';
import 'pages/screenshot_page.dart';
import 'pages/settings_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ADB GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: Routes.connections,
        routes: [
          ShellRoute(
            builder: (context, state, child) => AppShell(body: child),
            routes: [
              GoRoute(
                path: Routes.automations,
                builder: (context, state) => const AutomationsPage(),
              ),
              GoRoute(
                path: Routes.connections,
                builder: (context, state) => const ConnectionsPage(),
              ),
              GoRoute(
                path: Routes.emulators,
                builder: (context, state) => EmulatorsPage(),
              ),
              GoRoute(
                path: Routes.install,
                builder: (context, state) => const InstallPage(),
              ),
              GoRoute(
                path: Routes.keyboard,
                builder: (context, state) => const KeyboardPage(),
              ),
              GoRoute(
                path: Routes.proxies,
                builder: (context, state) => ProxiesPage(),
              ),
              GoRoute(
                path: Routes.remoteControl,
                builder: (context, state) => RemoteControlPage(),
              ),
              GoRoute(
                path: Routes.screenshot,
                builder: (context, state) => const ScreenshotPage(),
              ),
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
