import 'package:flutter/material.dart';

import '../../services/keyboard_service.dart';
import '../../util/singleton_registry.dart';
import '../intents/send_text_intent.dart';

class SendTextAction extends ContextAction<SendTextIntent> {
  final KeyboardService _service = SingletonRegistry.get();

  final TextEditingController _controller;

  SendTextAction(this._controller);

  @override
  Object? invoke(SendTextIntent intent, [BuildContext? context]) {
    if (context != null) {
      _service
          .sendText(context, intent.activeDevice, _controller.text)
          .then(_onSent);
    }
    return null;
  }

  void _onSent(bool success) {
    if (success) {
      _controller.text = '';
    }
  }
}
