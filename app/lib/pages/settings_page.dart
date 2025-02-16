import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../extensions/iterable_ext.dart';
import '../models/setting.dart';
import '../models/setting_id.dart';
import '../services/setting_service.dart';
import '../util/singleton_registry.dart';
import '../util/text_editing_controller_debouncer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingService _service = SingletonRegistry.get();
  late final Future<List<Setting>> _settings = _service.getAll();
  final List<TextEditingControllerDebouncer> _debouncers = [];
  final List<TextEditingController> _textControllers = [];

  @override
  void initState() {
    super.initState();
    _settings.then((settings) {
      for (var setting in settings) {
        final controller = TextEditingController(text: setting.value);
        final debouncer = TextEditingControllerDebouncer(
          controller,
          1000,
          (value) {
            final newSetting = Setting()
              ..id = setting.id
              ..value = value;
            _service.put(newSetting);
          },
        );
        _debouncers.add(debouncer);
        _textControllers.add(controller);
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleSettings,
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: _settings,
          builder: (context, snapshot) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: snapshot.data
                    ?.mapIndexed(
                      (index, setting) => Flexible(
                        child: TextField(
                          controller: _textControllers.elementAt(index),
                          decoration: InputDecoration(
                            labelText: _getLabel(context, setting.id),
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }

  String? _getLabel(BuildContext context, int settingId) {
    final key = SettingKey.values.find((key) => key.id == settingId);
    switch (key) {
      case SettingKey.adbPath:
        return AppLocalizations.of(context)!.fieldSettingAdbPath;
      case SettingKey.emulatorPath:
        return AppLocalizations.of(context)!.fieldSettingEmulatorPath;
      case SettingKey.screenshotPath:
        return AppLocalizations.of(context)!.fieldSettingScreenshotDirectory;
      case null:
        return null;
    }
  }
}
