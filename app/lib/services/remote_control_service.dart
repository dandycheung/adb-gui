import 'package:flutter/material.dart';

import '../core/adb_executor.dart';
import '../models/device.dart';

class RemoteControlService {
  void sendKey(BuildContext context, Device? device, String key) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['shell', 'input', 'keyevent', 'KEYCODE_$key'],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }
}
