import 'package:flutter/material.dart';

import '../models/device.dart';
import '../models/setting_id.dart';
import '../services/setting_service.dart';
import '../util/singleton_registry.dart';
import 'executor.dart';

class AdbExecutor {
  static final SettingService _service = SingletonRegistry.get();

  static Future<String> execute({
    required List<String> arguments,
    Device? device,
  }) async {
    try {
      String adbPath = await _service.getCurrentValue(SettingKey.adbPath);
      return await Executor.execute(
        command: adbPath,
        arguments: _addDeviceToArguments(device, arguments),
      );
    } catch (error) {
      debugPrint('Failed to execute adb command: $error');
      rethrow;
    }
  }

  static Future<Iterable<String>> executeAndSplit({
    required List<String> arguments,
    Device? device,
  }) async {
    try {
      String response = await execute(arguments: arguments, device: device);
      return response.split('\n').where((line) => !line.startsWith('* '));
    } catch (error) {
      return [];
    }
  }

  static Future<bool> executeAndValidate({
    required List<String> arguments,
    Device? device,
    required Iterable<String> regexes,
    required BuildContext context,
  }) async {
    String adbPath = await _service.getCurrentValue(SettingKey.adbPath);
    if (!context.mounted) {
      return false;
    }
    return Executor.executeAndValidate(
      command: adbPath,
      arguments: _addDeviceToArguments(device, arguments),
      regexes: regexes,
      context: context,
    );
  }

  static List<String> _addDeviceToArguments(
      Device? device, List<String> arguments) {
    if (device == null) {
      return arguments;
    } else {
      return ['-s', device.address, ...arguments];
    }
  }
}
