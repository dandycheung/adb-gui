import 'package:flutter/material.dart';

import '../../models/proxy.dart';
import 'socket_type_selector.dart';

class SocketEditor extends StatelessWidget {
  final String label;
  final ProxyType proxyType;
  final Socket socket;
  final ValueChanged<SocketType> onTypeChanged;
  final ValueChanged<String> onNameChanged;

  const SocketEditor({
    super.key,
    required this.label,
    required this.proxyType,
    required this.socket,
    required this.onTypeChanged,
    required this.onNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SocketTypeSelector(
                  proxyType: proxyType,
                  socketType: socket.type,
                  onChanged: onTypeChanged,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    initialValue: socket.name,
                    onChanged: onNameChanged,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
