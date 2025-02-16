import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/proxies.dart';
import '../../models/proxy.dart';

class ProxyTypeSelector extends StatelessWidget {
  final ProxyType type;
  final ValueChanged<ProxyType> onChanged;

  const ProxyTypeSelector({
    super.key,
    required this.type,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: Text(AppLocalizations.of(context)!.fieldType),
      enableSearch: false,
      requestFocusOnTap: false,
      initialSelection: type,
      dropdownMenuEntries: Proxies.proxyTypeEntries,
      onSelected: (value) {
        if (value == null || type == value) {
          return;
        }
        onChanged(value);
      },
    );
  }
}
