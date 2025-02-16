import 'package:flutter/material.dart';

import '../../constants/automations.dart';
import '../../models/automation.dart';

class OperationSelector extends StatelessWidget {
  final Command command;
  final ValueChanged<Operation> onChanged;

  const OperationSelector({
    super.key,
    required this.command,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enableSearch: false,
      requestFocusOnTap: false,
      initialSelection: command.operation.type,
      dropdownMenuEntries: Automations.getOperationEntries(command.type),
      onSelected: (value) {
        if (value == null || command.operation.type == value) {
          return;
        }
        onChanged(Automations.getOperation(value));
      },
    );
  }
}
