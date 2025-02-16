import 'package:flutter/cupertino.dart';

import '../core/adb_executor.dart';
import '../models/device.dart';

class KeyboardService {
  void sendBackspaceKey(BuildContext context, Device? device) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['shell', 'input', 'keyevent', 'KEYCODE_DEL'],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }

  void sendTabKey(BuildContext context, Device? device) async {
    await AdbExecutor.executeAndValidate(
      arguments: ['shell', 'input', 'keyevent', 'KEYCODE_TAB'],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }

  Future<bool> sendText(BuildContext context, Device? device, String text) async {
    return await AdbExecutor.executeAndValidate(
      arguments: ['shell', 'input', 'keyboard', 'text', "'$text'"],
      device: device,
      regexes: ['^\$'],
      context: context,
    );
  }
}
