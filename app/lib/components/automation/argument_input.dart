import 'package:flutter/material.dart';

import '../../constants/automations.dart';
import '../../models/automation.dart';

class ArgumentInput extends StatelessWidget {
  final Argument argument;
  final ValueChanged<String> onValueChanged;

  const ArgumentInput({
    super.key,
    required this.argument,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (argument.inputType) {
      case InputType.select:
        return DropdownMenu(
          label: Text(argument.type.label),
          enableSearch: false,
          requestFocusOnTap: false,
          initialSelection: argument.value,
          dropdownMenuEntries: Automations.getSelectEntries(argument),
          onSelected: (value) {
            if (value == null) return;
            onValueChanged(value);
          },
        );
      case InputType.static:
        return Text(argument.value);
      case InputType.text:
        return TextFormField(
          decoration: InputDecoration(
            labelText: argument.type.label,
          ),
          initialValue: argument.value,
          onChanged: (value) => onValueChanged(value),
        );
    }
  }
}
