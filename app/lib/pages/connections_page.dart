import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/rxdart.dart';

import '../components/page_container.dart';
import '../components/table/row_factories/connection_row_factory.dart';
import '../components/table/table_wrapper.dart';
import '../dialogs/edit_connection_dialog.dart';
import '../models/connection.dart';
import '../models/connection_with_status.dart';
import '../models/device.dart';
import '../services/connection_service.dart';
import '../services/device_service.dart';
import '../util/singleton_registry.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  final ConnectionService _connectionService = SingletonRegistry.get();
  final DeviceService _deviceService = SingletonRegistry.get();
  final ConnectionRowFactory _rowFactory = ConnectionRowFactory();
  late Stream<List<ConnectionWithStatus>> _connections;

  _ConnectionsPageState() {
    _connections = CombineLatestStream(
      [_connectionService.getAll(), _deviceService.getAll()],
      (values) {
        List<Connection> connections = values[0] as List<Connection>;
        List<Device> devices = values[1] as List<Device>;
        return connections
            .map(
              (connection) => (
                connection: connection,
                isConnected: devices
                    .any((device) => device.address == connection.address),
              ),
            )
            .toList();
      },
    );
    _deviceService.loadDevices();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleConnections,
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditConnectionDialog.show(context, null),
        tooltip: AppLocalizations.of(context)!.buttonAdd,
        child: const Icon(Icons.add),
      ),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: _connections,
          builder: (context, snapshot) {
            return TableWrapper(
              columnNames: [
                AppLocalizations.of(context)!.fieldName,
                AppLocalizations.of(context)!.fieldAddress,
                AppLocalizations.of(context)!.fieldStatus,
                AppLocalizations.of(context)!.fieldActions,
              ],
              rowFactory: _rowFactory,
              items: snapshot.data ?? [],
            );
          },
        ),
      ),
    );
  }
}
