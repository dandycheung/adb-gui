import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import '../extensions/iterable_ext.dart';
import '../models/connection.dart';
import '../models/device.dart';
import '../models/device_with_name.dart';
import '../services/connection_service.dart';
import '../services/device_service.dart';
import '../util/singleton_registry.dart';

class DeviceSelector extends StatefulWidget {
  const DeviceSelector({super.key});

  @override
  State<StatefulWidget> createState() => _DeviceSelectorState();
}

class _DeviceSelectorState extends State<DeviceSelector> {
  final ConnectionService _connectionService = SingletonRegistry.get();
  final DeviceService _deviceService = SingletonRegistry.get();
  late Stream<(List<DeviceWithName>, Device?)> _data;

  final TextEditingController _controller = TextEditingController();

  _DeviceSelectorState() {
    _data = CombineLatestStream([
      _deviceService.getAll(),
      _deviceService.getActive(),
      _connectionService.getAll()
    ], (values) {
      final List<Device> devices = values[0] as List<Device>;
      final Device? activeDevice = values[1] as Device?;
      final List<Connection> connections = values[2] as List<Connection>;

      // workaround to clear the selected label from the button
      if (activeDevice == null) {
        _controller.value = TextEditingValue.empty;
      }

      return (
        devices
            .map((device) => (
                  device: device,
                  name: connections
                      .find(
                          (connection) => connection.address == device.address)
                      ?.name,
                ))
            .toList(),
        activeDevice
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _data,
      builder: (context, snapshot) => DropdownMenu(
        enabled: snapshot.data?.$1.isNotEmpty ?? false,
        initialSelection: snapshot.data?.$2,
        controller: _controller,
        label: Text(AppLocalizations.of(context)!.fieldDevice),
        width: 200,
        enableSearch: false,
        requestFocusOnTap: false,
        dropdownMenuEntries: snapshot.data?.$1
                .map(
                  (entry) => DropdownMenuEntry<Device>(
                    value: entry.device,
                    label: entry.name ?? entry.device.address,
                  ),
                )
                .toList() ??
            [],
        onSelected: (value) => _deviceService.setActiveDevice(value as Device?),
      ),
    );
  }
}
