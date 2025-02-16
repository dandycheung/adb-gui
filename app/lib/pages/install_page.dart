import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../constants/config.dart';
import '../extensions/iterable_ext.dart';
import '../extensions/nullable_ext.dart';
import '../models/device.dart';
import '../models/install_mode.dart';
import '../services/device_service.dart';
import '../services/install_service.dart';
import '../util/singleton_registry.dart';

class InstallPage extends StatefulWidget {
  const InstallPage({super.key});

  @override
  State<StatefulWidget> createState() => _InstallPageState();
}

class _InstallPageState extends State<InstallPage> {
  final Stream<Device?> _activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final InstallService _service = SingletonRegistry.get();
  final TextEditingController _textController = TextEditingController();
  InstallMode _mode = InstallMode.normal;
  bool _isInstalling = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleInstall,
      child: DropTarget(
        onDragDone: (detail) {
          final file = detail.files
              .find((file) => file.name.endsWith(Config.installFileExtension));
          if (file != null) {
            _textController.text = file.path;
          }
        },
        child: StreamBuilder(
          stream: _activeDevice,
          builder: (context, snapshot) => Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.fieldPackagePath,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final file = await openFile(
                        acceptedTypeGroups: const [
                          XTypeGroup(
                            label: Config.installFileExtension,
                            extensions: [Config.installFileExtension],
                          )
                        ],
                        confirmButtonText:
                            AppLocalizations.of(context)!.buttonSelect,
                      );
                      if (file != null) {
                        _textController.text = file.path;
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.buttonBrowse),
                  ),
                  const SizedBox(width: 10.0),
                  DropdownMenu(
                    label: Text(AppLocalizations.of(context)!.fieldMode),
                    enableSearch: false,
                    requestFocusOnTap: false,
                    initialSelection: _mode,
                    dropdownMenuEntries: InstallMode.values
                        .map(
                          (mode) =>
                              DropdownMenuEntry(value: mode, label: mode.label),
                        )
                        .toList(),
                    onSelected: (value) => setState(() {
                      if (value == null) return;
                      _mode = value;
                    }),
                  ),
                  const SizedBox(width: 10.0),
                  _isInstalling
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: snapshot.data?.let(
                            (activeDevice) => () async {
                              setState(() {
                                _isInstalling = true;
                              });
                              await _service.install(
                                context,
                                activeDevice,
                                _textController.text,
                                _mode,
                              );
                              setState(() {
                                _isInstalling = false;
                              });
                            },
                          ),
                          icon: const Icon(Icons.install_mobile),
                          tooltip: AppLocalizations.of(context)!.buttonInstall,
                        ),
                ],
              ),
              ...(_mode == InstallMode.privApp
                  ? [
                      const SizedBox(height: 10.0),
                      Text(
                        AppLocalizations.of(context)!.warningPrivApp,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ]
                  : []),
            ],
          ),
        ),
      ),
    );
  }
}
