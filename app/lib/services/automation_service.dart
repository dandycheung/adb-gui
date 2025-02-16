import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

import '../core/adb_executor.dart';
import '../core/database.dart';
import '../models/automation.dart';
import '../models/device.dart';

class AutomationService {
  Stream<List<Automation>> getAll() {
    return database.asStream().asyncExpand((db) {
      return db.automations.where().watch(fireImmediately: true).doOnData(
          (automation) => automation.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
    });
  }

  Future<void> put(Automation automation) async {
    var db = await database;
    await db.writeTxn(() async {
      await db.automations.put(automation);
    });
  }

  Future<void> delete(Automation automation) async {
    var db = await database;
    await db.writeTxn(() async {
      db.automations.delete(automation.id);
    });
  }

  void run(
    BuildContext context,
    Device device,
    Automation automation,
  ) async {
    for (var command in automation.commands) {
      if (!context.mounted) {
        break;
      }
      bool success = await _runCommand(context, device, command);
      if (!success) {
        debugPrint('Failed to run automation');
        break;
      }
    }
  }

  Future<bool> _runCommand(
    BuildContext context,
    Device device,
    Command command,
  ) async {
    final List<String> arguments = command.operation.arguments
        .map((argument) => argument.type == ArgumentType.text
            ? "'${argument.value}'"
            : argument.value)
        .toList();
    switch (command.type) {
      case CommandType.adb:
        return await AdbExecutor.executeAndValidate(
          arguments: arguments,
          device: device,
          regexes: [],
          context: context,
        );
    }
  }
}
