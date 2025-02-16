import 'package:flutter/material.dart';

import 'dialog_cancel_button.dart';

class DialogContainer extends StatelessWidget {
  final String title;
  final String confirmLabel;
  final VoidCallback confirmAction;
  final Widget child;

  const DialogContainer({
    super.key,
    required this.title,
    required this.child,
    required this.confirmLabel,
    required this.confirmAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(thickness: 2.0),
            Flexible(
              child: SingleChildScrollView(child: child),
            ),
            const Divider(thickness: 2.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 10.0,
              children: [
                ElevatedButton(
                  onPressed: confirmAction,
                  child: Text(confirmLabel),
                ),
                const DialogCancelButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
