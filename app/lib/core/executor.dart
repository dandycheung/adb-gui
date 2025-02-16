import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class Executor {
  static Future<String> execute({
    required String command,
    List<String>? arguments,
  }) async {
    ProcessResult result = await Process.run(command, arguments ?? []);

    if (result.exitCode == 0) {
      return result.stdout as String? ?? '';
    }

    String? error = result.stderr as String?;
    if (error != null && error.isNotEmpty) {
      throw Exception(error);
    }
    throw Exception(result.stdout as String?);
  }

  static Future<bool> executeAndValidate({
    required String command,
    List<String>? arguments,
    required Iterable<String> regexes,
    required BuildContext context,
  }) async {
    try {
      String response = await execute(command: command, arguments: arguments);
      if (_validate(response, regexes)) {
        return true;
      }
      if (context.mounted) {
        _showErrorMessage(context, response.trim());
      }
      return false;
    } catch (error) {
      if (context.mounted) {
        _showErrorMessage(context, error.toString().trim());
      }
      return false;
    }
  }

  static void executeAsync({
    required String command,
    List<String>? arguments,
  }) async {
    await Process.start(command, arguments ?? []);
  }

  static void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Error: $message'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static bool _validate(String response, Iterable<String> regexes) {
    return regexes.isEmpty ||
        regexes.any(
          (regex) => RegExp(
            regex,
            multiLine: true,
            caseSensitive: false,
          ).hasMatch(response),
        );
  }
}
