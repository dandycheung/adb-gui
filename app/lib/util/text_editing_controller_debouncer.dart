import 'dart:async';

import 'package:flutter/material.dart';

class TextEditingControllerDebouncer {
  final TextEditingController controller;
  final int delayMs;
  final void Function(String value) onChanged;
  Timer? _timer;

  TextEditingControllerDebouncer(
    this.controller,
    this.delayMs,
    this.onChanged,
  ) {
    controller.addListener(() {
      if (_timer?.isActive == true) {
        _timer?.cancel();
      }
      _timer = Timer(
        Duration(milliseconds: delayMs),
        () => onChanged(controller.text),
      );
    });
  }
}
