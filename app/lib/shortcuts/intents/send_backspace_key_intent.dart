import 'package:flutter/material.dart';

import '../../models/device.dart';

class SendBackspaceKeyIntent extends Intent {
  final Device? activeDevice;

  const SendBackspaceKeyIntent(this.activeDevice);
}
