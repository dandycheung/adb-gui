import 'package:flutter/material.dart';

import '../models/proxy.dart';

class Proxies {
  static List<DropdownMenuEntry<ProxyType>> proxyTypeEntries = ProxyType.values
      .map((type) => DropdownMenuEntry(value: type, label: type.typeName))
      .toList();

  static SocketType getSocketType(ProxyType proxyType) {
    return getSocketTypeEntries(proxyType).first.value;
  }

  static List<DropdownMenuEntry<SocketType>> getSocketTypeEntries(ProxyType proxyType) {
    return SocketType.values
        .where((type) => type.proxyTypes.contains(proxyType))
        .map((type) => DropdownMenuEntry(label: type.typeName, value: type))
        .toList();
  }
}
