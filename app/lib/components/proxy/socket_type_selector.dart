import 'package:flutter/material.dart';

import '../../constants/proxies.dart';
import '../../models/proxy.dart';

class SocketTypeSelector extends StatelessWidget {
  final ProxyType proxyType;
  final SocketType socketType;
  final ValueChanged<SocketType> onChanged;

  const SocketTypeSelector({
    super.key,
    required this.proxyType,
    required this.socketType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enableSearch: false,
      requestFocusOnTap: false,
      initialSelection: socketType,
      dropdownMenuEntries: Proxies.getSocketTypeEntries(proxyType),
      onSelected: (value) {
        if (value == null || socketType == value) {
          return;
        }
        onChanged(value);
      },
    );
  }
}
