import 'dart:io';

import '../core/database.dart';
import '../core/executor.dart';
import '../models/setting.dart';
import '../models/setting_id.dart';

class SettingService {
  SettingService() {
    // initialize settings with default values if they don't exist yet
    database.then(
      (db) => db.writeTxn(
        () async {
          await Future.forEach(SettingKey.values, (key) async {
            if ((await db.settings.get(key.id)) == null) {
              Setting setting = Setting()
                ..id = key.id
                ..value = await _getDefaultValue(key);
              await db.settings.put(setting);
            }
          });
        },
      ),
    );
  }

  Future<List<Setting>> getAll() async {
    final db = await database;
    return db.settings
        .getAll(SettingKey.values.map((key) => key.id).toList())
        .then((settings) => settings.nonNulls.toList());
  }

  Future<String> getCurrentValue(SettingKey key) async {
    final db = await database;
    final setting = await db.settings.get(key.id);
    return setting?.value ?? _getDefaultValue(key);
  }

  void put(Setting setting) async {
    final db = await database;
    await db.writeTxn(() async {
      await db.settings.put(setting);
    });
  }

  Future<String> _getDefaultValue(SettingKey id) async {
    switch (id) {
      case SettingKey.adbPath:
        return await _findExecutablePath('adb') ??
            '${Platform.environment['HOME']}/Android/Sdk/platform-tools/adb';
      case SettingKey.emulatorPath:
        return await _findExecutablePath('emulator') ??
            '${Platform.environment['HOME']}/Android/Sdk/emulator/emulator';
      case SettingKey.screenshotPath:
        return '${Platform.environment['HOME']}/Pictures/Screenshots';
    }
  }

  Future<String?> _findExecutablePath(String executableName) async {
    try {
      String result =
          await Executor.execute(command: 'which', arguments: [executableName]);
      if (result.isEmpty) {
        return null;
      }
      return result;
    } catch (error) {
      return null;
    }
  }
}
