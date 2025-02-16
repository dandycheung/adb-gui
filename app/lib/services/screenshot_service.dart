import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/adb_executor.dart';
import '../core/executor.dart';
import '../models/device.dart';

class ScreenshotService {
  static const String fileExtension = 'png';
  static const String _deviceDirectory = '/sdcard/adb-gui';
  static const String _tempPath =
      '$_deviceDirectory/tmp-screenshot.$fileExtension';
  static final DateFormat _dateFormat = DateFormat('yyyyMMdd-hhmmss');

  Future<String?> takeScreenshot(
    BuildContext context,
    Device device,
    String directory,
  ) async {
    final timestamp = _dateFormat.format(DateTime.now());
    final path = '$directory/screenshot-$timestamp.$fileExtension';
    if (!context.mounted || !await _createDirectoryOnDevice(context, device)) {
      return null;
    }
    if (!context.mounted || !await _createScreenshotOnDevice(context, device)) {
      return null;
    }
    if (!context.mounted || !await _createLocalDirectory(context, directory)) {
      return null;
    }
    if (!context.mounted ||
        !await _downloadScreenshotFromDevice(context, device, path)) {
      return null;
    }
    if (!context.mounted || !await _deleteScreenshotOnDevice(context, device)) {
      return null;
    }
    return path;
  }

  Future<bool> _createDirectoryOnDevice(BuildContext context, Device device) {
    return AdbExecutor.executeAndValidate(
      arguments: ['shell', 'mkdir', '-p', _deviceDirectory],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }

  Future<bool> _createScreenshotOnDevice(BuildContext context, Device device) {
    return AdbExecutor.executeAndValidate(
      arguments: ['shell', 'screencap', '-p', _tempPath],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }

  Future<bool> _createLocalDirectory(BuildContext context, String directory) {
    return Executor.executeAndValidate(
      command: 'mkdir',
      arguments: ['-p', directory],
      regexes: ['^\$'],
      context: context,
    );
  }

  Future<bool> _downloadScreenshotFromDevice(
    BuildContext context,
    Device device,
    String path,
  ) async {
    if (!await AdbExecutor.executeAndValidate(
      arguments: ['pull', _tempPath, path],
      device: device,
      regexes: ['^(?!adb: error:).*'],
      context: context,
    )) {
      return false;
    }
    return true;
  }

  Future<bool> _deleteScreenshotOnDevice(BuildContext context, Device device) {
    return AdbExecutor.executeAndValidate(
      arguments: ['shell', 'rm', _tempPath],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }
}
