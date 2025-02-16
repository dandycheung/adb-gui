import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../dialogs/delete_connection_dialog.dart';
import '../../../dialogs/edit_connection_dialog.dart';
import '../../../models/connection_with_status.dart';
import '../../../services/device_service.dart';
import '../../../util/singleton_registry.dart';
import 'row_factory.dart';

class ConnectionRowFactory extends RowFactory<ConnectionWithStatus> {
  final DeviceService _deviceService = SingletonRegistry.get();

  @override
  DataRow create(BuildContext context, ConnectionWithStatus data) {
    return DataRow(cells: [
      DataCell(Text(data.connection.name)),
      DataCell(Text(data.connection.address)),
      DataCell(Tooltip(
        message: data.isConnected
            ? AppLocalizations.of(context)!.valueConnected
            : AppLocalizations.of(context)!.valueDisconnected,
        child: Icon(data.isConnected ? Icons.check : Icons.close),
      )),
      DataCell(OverflowBar(
        children: [
          IconButton(
            onPressed: () =>
                EditConnectionDialog.show(context, data.connection),
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.buttonEdit,
          ),
          IconButton(
            onPressed: () {
              if (data.isConnected) {
                _deviceService.disconnect(context, data.connection);
              } else {
                _deviceService.connect(context, data.connection);
              }
            },
            icon: Icon(data.isConnected ? Icons.link_off : Icons.link),
            tooltip: data.isConnected
                ? AppLocalizations.of(context)!.buttonDisconnect
                : AppLocalizations.of(context)!.buttonConnect,
          ),
          IconButton(
            onPressed: () =>
                DeleteConnectionDialog.show(context, data.connection),
            icon: const Icon(Icons.delete),
            tooltip: AppLocalizations.of(context)!.buttonDelete,
          ),
        ],
      )),
    ]);
  }
}
