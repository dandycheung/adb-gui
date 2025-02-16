import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

import '../core/adb_executor.dart';
import '../core/database.dart';
import '../models/device.dart';
import '../models/proxy.dart';
import '../models/proxy_with_status.dart';

class ProxyService {
  final Stream<List<Proxy>> _savedProxies =
      database.asStream().asyncExpand((db) {
    return db.proxys.where().watch(fireImmediately: true);
  });
  final BehaviorSubject<List<Proxy>> _activeProxies = BehaviorSubject();
  late final Stream<List<ProxyWithStatus>> _proxiesWithStatus =
      CombineLatestStream(
    [_savedProxies, _activeProxies],
    (values) => values[0]
        .map(
          (savedProxy) => (
            proxy: savedProxy,
            isActive: values[1].any((activeProxy) =>
                savedProxy.type == activeProxy.type &&
                savedProxy.from == activeProxy.from &&
                savedProxy.to == activeProxy.to),
          ),
        )
        .toList(),
  ).asBroadcastStream();
  Device? _activeDevice;

  void changeActiveDevice(Device? device) {
    _activeDevice = device;
    _loadActiveProxies();
  }

  Stream<List<ProxyWithStatus>> getAll() {
    return _proxiesWithStatus;
  }

  Future<void> put(Proxy proxy) async {
    var db = await database;
    await db.writeTxn(() async {
      await db.proxys.put(proxy);
    });
  }

  Future<void> delete(Proxy proxy) async {
    var db = await database;
    await db.writeTxn(() async {
      db.proxys.delete(proxy.id);
    });
  }

  void connect(BuildContext context, Device device, Proxy proxy) async {
    await AdbExecutor.executeAndValidate(
      arguments: [
        proxy.type.typeName,
        '${proxy.from.type.typeName}:${proxy.from.name}',
        '${proxy.to.type.typeName}:${proxy.to.name}'
      ],
      device: device,
      regexes: ['^\\s*${proxy.from.name}\\s*\$'],
      context: context,
    );
    _loadActiveProxies();
  }

  void disconnect(BuildContext context, Device device, Proxy proxy) async {
    await AdbExecutor.executeAndValidate(
      arguments: [
        proxy.type.typeName,
        '--remove',
        '${proxy.from.type.typeName}:${proxy.from.name}',
      ],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
    _loadActiveProxies();
  }

  Future<List<Proxy>> _getActiveProxies(Device? device, ProxyType type) async {
    return (await AdbExecutor.executeAndSplit(
      arguments: [type.typeName, '--list'],
      device: device,
    ))
        .map((line) => line.trim().split(RegExp(r'\s+')))
        .where((tokens) => tokens.length == 3)
        .map(
          (tokens) {
            try {
              return Proxy()
                ..type = type
                ..from = Socket.fromString(tokens[1])
                ..to = Socket.fromString(tokens[2]);
            } catch (error) {
              debugPrint(error.toString());
              return null;
            }
          },
        )
        .nonNulls
        .toList();
  }

  void _loadActiveProxies() async {
    if (_activeDevice == null) {
      _activeProxies.add([]);
      return;
    }
    List<Proxy> forwardProxies =
        await _getActiveProxies(_activeDevice, ProxyType.forward);
    List<Proxy> reverseProxies =
        await _getActiveProxies(_activeDevice, ProxyType.reverse);
    List<Proxy> activeProxies = forwardProxies + reverseProxies;

    _activeProxies.add(activeProxies);

    var db = await database;
    await db.writeTxn(() async {
      List<Proxy> savedProxies = await db.proxys.where().findAll();
      await Future.forEach(activeProxies, (activeProxy) async {
        if (!savedProxies.any(
          (savedProxy) =>
              savedProxy.type == activeProxy.type &&
              savedProxy.from == activeProxy.from &&
              savedProxy.to == activeProxy.to,
        )) {
          await db.proxys.put(activeProxy);
        }
      });
    });
  }
}
