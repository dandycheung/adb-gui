import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../models/key_code.dart';

class KeyCodes {
  static List<KeyCode> all =
      KeyCode.values.sortedBy((keyCode) => keyCode.label);

  static List<DropdownMenuEntry<String>> selectEntries = all
      .map((keyCode) => DropdownMenuEntry(label: keyCode.label, value: keyCode.code))
      .toList();
}
