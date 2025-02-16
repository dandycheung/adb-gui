import 'package:flutter/material.dart';

import '../../services/keyboard_service.dart';
import '../../util/singleton_registry.dart';
import '../intents/send_tab_key_intent.dart';

class SendTabKeyAction extends ContextAction<SendTabKeyIntent> {
  final KeyboardService _service = SingletonRegistry.get();

  @override
  Object? invoke(SendTabKeyIntent intent, [BuildContext? context]) {
    if (context != null) {
      _service.sendTabKey(context, intent.activeDevice);
    }
    return null;
  }
}
