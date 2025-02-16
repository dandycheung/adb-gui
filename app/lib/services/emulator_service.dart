import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

import '../core/database.dart';
import '../core/emulator_executor.dart';
import '../models/emulator.dart';

class EmulatorService {
  final Stream<List<Emulator>> _savedEmulators =
      database.asStream().asyncExpand(
            (db) => db.emulators.where().watch(fireImmediately: true).doOnData(
                  (proxy) => proxy.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  ),
                ),
          );
  final BehaviorSubject<List<String>> _availableEmulators = BehaviorSubject();
  late final Stream<List<Emulator>> _emulators = CombineLatestStream.combine2(
    _savedEmulators,
    _availableEmulators,
    (savedEmulators, availableEmulators) => savedEmulators
        .where((emulator) => availableEmulators.contains(emulator.name))
        .toList(),
  ).asBroadcastStream();

  Stream<List<Emulator>> getAll() {
    return _emulators;
  }

  Future<void> put(Emulator emulator) async {
    var db = await database;
    await db.writeTxn(() async {
      await db.emulators.put(emulator);
    });
  }

  void loadEmulators() async {
    Iterable<String> lines =
        await EmulatorExecutor.executeAndSplit(arguments: ['-list-avds']);
    List<String> emulatorNames = lines
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    _availableEmulators.add(emulatorNames);

    var db = await database;
    await db.writeTxn(() async {
      List<Emulator> savedEmulators = await db.emulators.where().findAll();
      await Future.forEach(emulatorNames, (name) async {
        if (!savedEmulators.any((emulator) => emulator.name == name)) {
          Emulator emulator = Emulator()
            ..name = name
            ..params = EmulatorParams();
          await db.emulators.put(emulator);
        }
      });
    });
  }

  void start(BuildContext context, Emulator emulator) {
    List<String> arguments = ['-avd', emulator.name];
    if (emulator.params.noSnapshotLoad) {
      arguments.add('-no-snapshot-load');
    }
    if (emulator.params.writeableSystem) {
      arguments.add('-writable-system');
    }
    EmulatorExecutor.executeAsync(arguments: arguments);
  }
}
