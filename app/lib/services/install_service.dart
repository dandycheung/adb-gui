import 'package:flutter/material.dart';

import '../core/adb_executor.dart';
import '../models/device.dart';
import '../models/install_mode.dart';

class InstallService {
  Future<void> install(
    BuildContext context,
    Device device,
    String path,
    InstallMode mode,
  ) async {
    switch (mode) {
      case InstallMode.normal:
        await _installNormal(context, device, path);
      case InstallMode.privApp:
        await _installPrivApp(context, device, path);
    }
  }

  Future<void> _installNormal(
    BuildContext context,
    Device device,
    String path,
  ) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['install', path],
      device: device,
      regexes: ['.*success\$'],
      context: context,
    );
  }

  Future<void> _installPrivApp(
    BuildContext context,
    Device device,
    String path,
  ) async {
    if (!context.mounted ||
        !await AdbExecutor.executeAndValidate(
          arguments: ['root'],
          device: device,
          regexes: [
            '^restarting adbd as root\$',
            '^adbd is already running as root\$'
          ],
          context: context,
        )) {
      return;
    }
    if (!context.mounted ||
        !await AdbExecutor.executeAndValidate(
          arguments: ['remount', path],
          device: device,
          regexes: ['^remount succeeded\$'],
          context: context,
        )) {
      return;
    }
    await AdbExecutor.execute(
      arguments: ['push', path, '/system/priv-app'],
      device: device,
    );
    await AdbExecutor.execute(
      arguments: ['reboot'],
      device: device,
    );
  }
}
