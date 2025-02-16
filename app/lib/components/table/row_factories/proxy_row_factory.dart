import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../dialogs/delete_proxy_dialog.dart';
import '../../../dialogs/edit_proxy_dialog.dart';
import '../../../extensions/nullable_ext.dart';
import '../../../models/device.dart';
import '../../../models/proxy_with_status.dart';
import '../../../services/device_service.dart';
import '../../../services/proxy_service.dart';
import '../../../util/singleton_registry.dart';
import 'row_factory.dart';

class ProxyRowFactory extends RowFactory<ProxyWithStatus> {
  final Stream<Device?> _activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final ProxyService _proxyService = SingletonRegistry.get();

  @override
  DataRow create(BuildContext context, ProxyWithStatus data) {
    return DataRow(cells: [
      DataCell(Text(data.proxy.type.typeName)),
      DataCell(
          Text('${data.proxy.from.type.typeName} ${data.proxy.from.name}')),
      DataCell(Text('${data.proxy.to.type.typeName} ${data.proxy.to.name}')),
      DataCell(Tooltip(
        message: data.isActive
            ? AppLocalizations.of(context)!.valueActive
            : AppLocalizations.of(context)!.valueInactive,
        child: Icon(data.isActive ? Icons.check : Icons.close),
      )),
      DataCell(OverflowBar(
        children: [
          StreamBuilder(
            stream: _activeDevice,
            builder: (context, snapshot) => IconButton(
              onPressed: snapshot.data?.let(
                (activeDevice) => () {
                  if (data.isActive) {
                    _proxyService.disconnect(context, activeDevice, data.proxy);
                  } else {
                    _proxyService.connect(context, activeDevice, data.proxy);
                  }
                },
              ),
              icon: Icon(data.isActive ? Icons.link_off : Icons.link),
              tooltip: data.isActive
                  ? AppLocalizations.of(context)!.buttonDeactivate
                  : AppLocalizations.of(context)!.buttonActivate,
            ),
          ),
          IconButton(
            onPressed: () => EditProxyDialog.show(context, data.proxy),
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.buttonEdit,
          ),
          IconButton(
            onPressed: () => DeleteProxyDialog.show(context, data.proxy),
            icon: const Icon(Icons.delete),
            tooltip: AppLocalizations.of(context)!.buttonDelete,
          ),
        ],
      )),
    ]);
  }
}
