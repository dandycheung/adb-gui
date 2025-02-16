import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dialog_container.dart';
import '../components/proxy/proxy_type_selector.dart';
import '../components/proxy/socket_editor.dart';
import '../constants/proxies.dart';
import '../models/proxy.dart';
import '../services/proxy_service.dart';
import '../util/singleton_registry.dart';

class EditProxyDialog extends StatefulWidget {
  final Proxy? proxy;

  const EditProxyDialog({super.key, this.proxy});

  static void show(BuildContext context, Proxy? proxy) {
    showDialog(
      context: context,
      builder: (_) => EditProxyDialog(proxy: proxy),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditProxyDialogState();
}

class _EditProxyDialogState extends State<EditProxyDialog> {
  final ProxyService _service = SingletonRegistry.get();

  late ProxyType _type;
  late Socket _from;
  late Socket _to;

  @override
  void initState() {
    super.initState();
    _type = widget.proxy?.type ?? ProxyType.values.first;
    _from = widget.proxy?.from ??
        (Socket()
          ..type = Proxies.getSocketType(_type)
          ..name = '');
    _to = widget.proxy?.to ??
        (Socket()
          ..type = Proxies.getSocketType(_type)
          ..name = '');
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.proxy?.id;
    final title = id == null
        ? AppLocalizations.of(context)!.dialogTitleProxyAdd
        : AppLocalizations.of(context)!.dialogTitleProxyEdit;
    final saveButtonLabel = id == null
        ? AppLocalizations.of(context)!.buttonAdd
        : AppLocalizations.of(context)!.buttonSave;
    return DialogContainer(
      title: title,
      confirmLabel: saveButtonLabel,
      confirmAction: () => _onSave(id, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProxyTypeSelector(
            type: _type,
            onChanged: (value) => setState(() {
              _type = value;
              if (!_from.type.proxyTypes.contains(value)) {
                _from.type = Proxies.getSocketType(value);
              }
              if (!_to.type.proxyTypes.contains(value)) {
                _to.type = Proxies.getSocketType(value);
              }
            }),
          ),
          const SizedBox(height: 10.0),
          SocketEditor(
            label: AppLocalizations.of(context)!.fieldFrom,
            proxyType: _type,
            socket: _from,
            onTypeChanged: (value) => setState(() {
              _from.type = value;
            }),
            onNameChanged: (value) => setState(() {
              _from.name = value;
            }),
          ),
          const SizedBox(height: 10.0),
          SocketEditor(
            label: AppLocalizations.of(context)!.fieldTo,
            proxyType: _type,
            socket: _to,
            onTypeChanged: (value) => setState(() {
              _to.type = value;
            }),
            onNameChanged: (value) => setState(() {
              _to.name = value;
            }),
          ),
        ],
      ),
    );
  }

  void _onSave(int? id, BuildContext context) async {
    final proxy = Proxy()
      ..type = _type
      ..from = _from
      ..to = _to;
    if (id != null) {
      proxy.id = id;
    }
    await _service.put(proxy);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
