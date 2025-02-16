import 'package:flutter/material.dart';

import '../../services/keyboard_service.dart';
import '../../util/singleton_registry.dart';
import '../intents/send_backspace_key_intent.dart';

class SendBackspaceKeyAction extends ContextAction<SendBackspaceKeyIntent> {
  final KeyboardService _service = SingletonRegistry.get();

  @override
  Object? invoke(SendBackspaceKeyIntent intent, [BuildContext? context]) {
    if (context != null) {
      _service.sendBackspaceKey(context, intent.activeDevice);
    }
    return null;
  }
}
