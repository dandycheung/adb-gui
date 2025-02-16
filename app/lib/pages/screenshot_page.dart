import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../extensions/nullable_ext.dart';
import '../models/device.dart';
import '../models/setting_id.dart';
import '../services/device_service.dart';
import '../services/screenshot_service.dart';
import '../services/setting_service.dart';
import '../util/singleton_registry.dart';

class ScreenshotPage extends StatefulWidget {
  const ScreenshotPage({super.key});

  @override
  State<StatefulWidget> createState() => _ScreenshotPageState();
}

class _ScreenshotPageState extends State<ScreenshotPage> {
  final Stream<Device?> activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final ScreenshotService _screenshotService = SingletonRegistry.get();
  final SettingService _settingService = SingletonRegistry.get();
  final TextEditingController _textController = TextEditingController();
  File? _lastScreenshotFile;

  @override
  void initState() {
    super.initState();
    _settingService.getCurrentValue(SettingKey.screenshotPath).then((value) {
      _textController.text = value;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentScreenshotFile = _lastScreenshotFile;
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleScreenshot,
      child: StreamBuilder(
        stream: activeDevice,
        builder: (context, snapshot) => Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .fieldScreenshotDirectory,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final directory = await getDirectoryPath(
                      confirmButtonText:
                          AppLocalizations.of(context)!.buttonSelect,
                      initialDirectory: _textController.text,
                    );
                    if (directory != null) {
                      _textController.text = directory;
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.buttonBrowse),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  onPressed: snapshot.data?.let(
                    (activeDevice) => () async {
                      final screenshotPath =
                          await _screenshotService.takeScreenshot(
                        context,
                        activeDevice,
                        _textController.text,
                      );
                      if (screenshotPath != null) {
                        setState(() {
                          _lastScreenshotFile = File(screenshotPath);
                        });
                      }
                    },
                  ),
                  icon: const Icon(Icons.screenshot),
                  tooltip:
                      AppLocalizations.of(context)!.buttonCaptureScreenshot,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            if (currentScreenshotFile != null)
              Expanded(child: Image.file(currentScreenshotFile)),
          ],
        ),
      ),
    );
  }
}
