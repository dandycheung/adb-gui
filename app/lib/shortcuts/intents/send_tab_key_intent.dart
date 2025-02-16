import 'package:flutter/material.dart';

import '../../models/device.dart';

class SendTabKeyIntent extends Intent {
  final Device? activeDevice;

  const SendTabKeyIntent(this.activeDevice);
}
