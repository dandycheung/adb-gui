import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

import '../core/database.dart';
import '../models/connection.dart';

class ConnectionService {
  Stream<List<Connection>> getAll() {
    return database.asStream().asyncExpand((db) {
      return db.connections.where().watch(fireImmediately: true).doOnData(
          (connections) => connections.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
    });
  }

  Future<void> put(Connection connection) async {
    var db = await database;
    await db.writeTxn(() async {
      await db.connections.put(connection);
    });
  }

  Future<void> delete(Connection connection) async {
    var db = await database;
    await db.writeTxn(() async {
      db.connections.delete(connection.id);
    });
  }
}
