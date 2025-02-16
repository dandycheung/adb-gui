import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogCancelButton extends StatelessWidget {
  const DialogCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: Text(AppLocalizations.of(context)!.buttonCancel),
    );
  }
}
