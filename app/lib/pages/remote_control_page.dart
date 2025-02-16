import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../models/device.dart';
import '../models/remote_control_button.dart';
import '../services/device_service.dart';
import '../services/remote_control_service.dart';
import '../util/singleton_registry.dart';

const List<List<RemoteControlButton?>> buttons = [
  [
    (Icons.power_settings_new, null, 'power', 'POWER'),
    null,
    (Icons.search, null, 'assistant', 'SEARCH')
  ],
  [
    null,
    (Icons.arrow_drop_up, null, 'up', 'DPAD_UP'),
    (Icons.info, null, 'info', 'INFO')
  ],
  [
    (Icons.arrow_left, null, 'left', 'DPAD_LEFT'),
    (null, null, 'ok', 'DPAD_CENTER'),
    (Icons.arrow_right, null, 'right', 'DPAD_RIGHT'),
  ],
  [
    (Icons.fiber_manual_record, null, 'record', 'MEDIA_RECORD'),
    (Icons.arrow_drop_down, null, 'down', 'DPAD_DOWN'),
    (Icons.menu_book, null, 'guide', 'GUIDE'),
  ],
  [
    (Icons.arrow_back, null, 'back', 'BACK'),
    (Icons.home, null, 'home', 'HOME'),
    (Icons.menu, null, 'menu', 'MENU'),
  ],
  [
    (Icons.fast_rewind, null, 'rewind', 'MEDIA_REWIND'),
    (Icons.play_arrow, null, 'play', 'MEDIA_PLAY_PAUSE'),
    (Icons.fast_forward, null, 'fast forward', 'MEDIA_FAST_FORWARD'),
  ],
  [
    (Icons.volume_up, null, 'volume up', 'VOLUME_UP'),
    null,
    (Icons.expand_less, null, 'channel down', 'PAGE_DOWN'),
  ],
  [
    (Icons.volume_down, null, 'volume down', 'VOLUME_DOWN'),
    (Icons.mic_off, null, 'mute', 'MUTE'),
    (Icons.expand_more, null, 'channel up', 'PAGE_UP'),
  ],
  [
    (null, '1', '1', '1'),
    (null, '2', '2', '2'),
    (null, '3', '3', '3'),
  ],
  [
    (null, '4', '4', '4'),
    (null, '5', '5', '5'),
    (null, '6', '6', '6'),
  ],
  [
    (null, '7', '7', '7'),
    (null, '8', '8', '8'),
    (null, '9', '9', '9'),
  ],
  [
    null,
    (null, '0', '0', '0'),
  ],
];

class RemoteControlPage extends StatelessWidget {
  final Stream<Device?> activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final RemoteControlService service = SingletonRegistry.get();

  RemoteControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleRemoteControl,
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: activeDevice,
          builder: (context, snapshot) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: buttons
                  .map((row) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: row
                            .map((button) => Flexible(
                                  child: button == null
                                      ? const IconButton(
                                          onPressed: null, icon: Text(''))
                                      : IconButton(
                                          onPressed: snapshot.data == null
                                              ? null
                                              : () => service.sendKey(context,
                                                  snapshot.data, button.$4),
                                          icon: button.$1 == null
                                              ? Text(button.$2 ?? button.$3)
                                              : Icon(button.$1),
                                          tooltip: button.$3,
                                        ),
                                ))
                            .toList(),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
