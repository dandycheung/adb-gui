import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../core/adb_executor.dart';
import '../models/connection.dart';
import '../models/device.dart';

class DeviceService {
  final BehaviorSubject<List<Device>> _devices = BehaviorSubject();
  final BehaviorSubject<Device?> _activeDevice = BehaviorSubject();

  Stream<List<Device>> getAll() {
    return _devices.stream;
  }

  Stream<Device?> getActive() {
    return _activeDevice.stream;
  }

  Device? getCurrentActive() {
    return _activeDevice.value;
  }

  void connect(BuildContext context, Connection connection) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['connect', connection.address],
      regexes: ['(already )?connected to .*'],
      context: context,
    );
    loadDevices();
  }

  void disconnect(BuildContext context, Connection connection) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['disconnect', connection.address],
      regexes: ['disconnected .*', "error: no such device '.*'"],
      context: context,
    );
    loadDevices();
  }

  void loadDevices() async {
    Iterable<String> lines =
        await AdbExecutor.executeAndSplit(arguments: ['devices']);
    List<Device> devices = lines
        .skip(1)
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .map((line) => line.split('\t'))
        .where((columns) => columns.length == 2)
        .map((columns) {
      List<String> parts = columns.first.split(':');
      return Device(parts.first, parts.elementAtOrNull(1));
    }).toList();
    _devices.add(devices);

    if (!devices.contains(_activeDevice.valueOrNull)) {
      _activeDevice.add(devices.firstOrNull);
    }
  }

  void setActiveDevice(Device? device) {
    _activeDevice.add(device);
  }
}
