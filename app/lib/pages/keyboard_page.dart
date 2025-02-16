import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../models/device.dart';
import '../services/device_service.dart';
import '../shortcuts/actions/send_backspace_key_action.dart';
import '../shortcuts/actions/send_tab_key_action.dart';
import '../shortcuts/actions/send_text_action.dart';
import '../shortcuts/intents/send_backspace_key_intent.dart';
import '../shortcuts/intents/send_tab_key_intent.dart';
import '../shortcuts/intents/send_text_intent.dart';
import '../util/singleton_registry.dart';

class KeyboardPage extends StatefulWidget {
  const KeyboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _KeyboardPageState();
}

class _KeyboardPageState extends State<KeyboardPage> {
  final DeviceService _deviceService = SingletonRegistry.get<DeviceService>();
  late final Stream<Device?> _activeDevice = _deviceService.getActive();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: {
        SingleActivator(
          LogicalKeyboardKey.backspace,
          control: true,
        ): SendBackspaceKeyIntent(_deviceService.getCurrentActive()),
        SingleActivator(
          LogicalKeyboardKey.enter,
          control: true,
        ): SendTextIntent(_deviceService.getCurrentActive()),
        SingleActivator(
          LogicalKeyboardKey.tab,
          control: true,
        ): SendTabKeyIntent(_deviceService.getCurrentActive()),
      },
      actions: {
        SendBackspaceKeyIntent: SendBackspaceKeyAction(),
        SendTabKeyIntent: SendTabKeyAction(),
        SendTextIntent: SendTextAction(_textController),
      },
      child: PageContainer(
        title: AppLocalizations.of(context)!.pageTitleKeyboard,
        child: StreamBuilder(
          stream: _activeDevice,
          builder: (context, snapshot) => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: snapshot.data == null
                        ? null
                        : Actions.handler(
                            context,
                            SendBackspaceKeyIntent(snapshot.data),
                          ),
                    icon: const Icon(Icons.backspace),
                    tooltip: AppLocalizations.of(context)!.buttonBackspace,
                  ),
                  IconButton(
                    onPressed: snapshot.data == null
                        ? null
                        : Actions.handler(
                            context,
                            SendTabKeyIntent(snapshot.data),
                          ),
                    icon: const Icon(Icons.keyboard_tab),
                    tooltip: AppLocalizations.of(context)!.buttonTab,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.fieldKeyboardInput,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: true,
                ),
              ),
              const SizedBox(width: 10.0),
              ValueListenableBuilder(
                valueListenable: _textController,
                builder: (context, value, child) => IconButton(
                  onPressed: snapshot.data == null || value.text.isEmpty
                      ? null
                      : Actions.handler(
                          context,
                          SendTextIntent(snapshot.data),
                        ),
                  icon: const Icon(Icons.send),
                  tooltip: AppLocalizations.of(context)!.buttonSend,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
