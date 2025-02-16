import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/page_container.dart';
import '../components/table/row_factories/proxy_row_factory.dart';
import '../components/table/table_wrapper.dart';
import '../dialogs/edit_proxy_dialog.dart';
import '../models/device.dart';
import '../models/proxy_with_status.dart';
import '../services/device_service.dart';
import '../services/proxy_service.dart';
import '../util/singleton_registry.dart';

class ProxiesPage extends StatelessWidget {
  final Stream<Device?> _activeDevice =
      SingletonRegistry.get<DeviceService>().getActive();
  final ProxyRowFactory _rowFactory = ProxyRowFactory();
  final ProxyService _service = SingletonRegistry.get();
  late final Stream<List<ProxyWithStatus>> _proxies = _service.getAll();

  ProxiesPage({super.key}) {
    _activeDevice.listen(_service.changeActiveDevice);
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageTitleProxies,
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditProxyDialog.show(context, null),
        tooltip: AppLocalizations.of(context)!.buttonAdd,
        child: const Icon(Icons.add),
      ),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: _proxies,
          builder: (context, snapshot) => TableWrapper(
            columnNames: [
              AppLocalizations.of(context)!.fieldType,
              AppLocalizations.of(context)!.fieldFrom,
              AppLocalizations.of(context)!.fieldTo,
              AppLocalizations.of(context)!.fieldStatus,
              AppLocalizations.of(context)!.fieldActions,
            ],
            rowFactory: _rowFactory,
            items: snapshot.data ?? [],
          ),
        ),
      ),
    );
  }
}
