import 'package:flutter/material.dart';

import '../../constants/automations.dart';
import '../../models/automation.dart';

class CommandSelector extends StatelessWidget {
  final Command command;
  final ValueChanged<Command> onChanged;

  const CommandSelector({
    super.key,
    required this.command,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      enableSearch: false,
      requestFocusOnTap: false,
      initialSelection: command.type,
      dropdownMenuEntries: Automations.commandEntries,
      onSelected: (value) {
        if (value == null || command.type == value) return;
        onChanged(Automations.getCommand(value));
      },
    );
  }
}
