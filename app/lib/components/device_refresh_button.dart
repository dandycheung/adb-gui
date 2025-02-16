import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/device_service.dart';
import '../util/singleton_registry.dart';

class DeviceRefreshButton extends StatelessWidget {
  late final DeviceService _service = SingletonRegistry.get();

  DeviceRefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _service.loadDevices();
      },
      icon: const Icon(Icons.refresh),
      tooltip: AppLocalizations.of(context)!.buttonRefresh,
    );
  }
}
