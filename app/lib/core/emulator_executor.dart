import 'package:flutter/material.dart';

import '../models/setting_id.dart';
import '../services/setting_service.dart';
import '../util/singleton_registry.dart';
import 'executor.dart';

class EmulatorExecutor {
  static final SettingService _service = SingletonRegistry.get();

  static Future<String> execute({required List<String> arguments}) async {
    try {
      String emulatorPath =
          await _service.getCurrentValue(SettingKey.emulatorPath);
      return await Executor.execute(
          command: emulatorPath, arguments: arguments);
    } catch (error) {
      debugPrint('Failed to execute adb command: $error');
      rethrow;
    }
  }

  static Future<Iterable<String>> executeAndSplit({
    required List<String> arguments,
  }) async {
    try {
      String response = await execute(arguments: arguments);
      return response.split('\n').where((line) => !line.startsWith('* '));
    } catch (error) {
      return [];
    }
  }

  static void executeAsync({required List<String> arguments}) async {
    String emulatorPath =
        await _service.getCurrentValue(SettingKey.emulatorPath);
    Executor.executeAsync(
      command: emulatorPath,
      arguments: arguments,
    );
  }
}
