import 'package:flutter/material.dart';

class Toggle extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool value) onChanged;

  const Toggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
