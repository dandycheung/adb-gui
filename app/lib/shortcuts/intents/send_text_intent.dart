import 'package:flutter/material.dart';

import '../../models/device.dart';

class SendTextIntent extends Intent {
  final Device? activeDevice;

  const SendTextIntent(this.activeDevice);
}
