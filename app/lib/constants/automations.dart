import 'package:flutter/material.dart';

import '../models/automation.dart';
import 'key_codes.dart';

class Automations {
  static List<DropdownMenuEntry<CommandType>> commandEntries = CommandType
      .values
      .map((type) => DropdownMenuEntry(value: type, label: type.label))
      .toList();

  static Argument getArgument(ArgumentType type, {String? value}) {
    switch (type) {
      case ArgumentType.keyCode:
        return Argument()
          ..type = ArgumentType.keyCode
          ..inputType = InputType.select
          ..value = value ?? KeyCodes.all.first.code;
      case ArgumentType.static:
        return Argument()
          ..type = ArgumentType.static
          ..inputType = InputType.static
          ..value = value ?? '';
      case ArgumentType.text:
        return Argument()
          ..type = ArgumentType.text
          ..inputType = InputType.text
          ..value = value ?? '';
    }
  }

  static Command getCommand(CommandType type) {
    switch (type) {
      case CommandType.adb:
        final operationTypeName =
            getOperationEntries(CommandType.adb).first.value;
        final operationType = OperationType.values
            .firstWhere((type) => type == operationTypeName);
        return Command()
          ..type = CommandType.adb
          ..operation = getOperation(operationType);
    }
  }

  static Operation getOperation(OperationType type) {
    switch (type) {
      case OperationType.keyboardInput:
        return Operation()
          ..type = OperationType.keyboardInput
          ..arguments = [
            getArgument(ArgumentType.static, value: 'shell'),
            getArgument(ArgumentType.static, value: 'input'),
            getArgument(ArgumentType.static, value: 'keyboard'),
            getArgument(ArgumentType.static, value: 'text'),
            getArgument(ArgumentType.text),
          ];
      case OperationType.keyCode:
        return Operation()
          ..type = OperationType.keyCode
          ..arguments = [
            getArgument(ArgumentType.static, value: 'shell'),
            getArgument(ArgumentType.static, value: 'input'),
            getArgument(ArgumentType.static, value: 'keyevent'),
            getArgument(ArgumentType.keyCode),
          ];
      case OperationType.reboot:
        return Operation()
          ..type = OperationType.reboot
          ..arguments = [getArgument(ArgumentType.static, value: 'reboot')];
    }
  }

  static List<DropdownMenuEntry<OperationType>> getOperationEntries(
    CommandType type,
  ) {
    final List<OperationType> operations;
    switch (type) {
      case CommandType.adb:
        operations = [
          OperationType.keyboardInput,
          OperationType.keyCode,
          OperationType.reboot
        ];
    }
    return operations
        .map((type) => DropdownMenuEntry(label: type.label, value: type))
        .toList();
  }

  static List<DropdownMenuEntry<String>> getSelectEntries(Argument argument) {
    if (argument.inputType != InputType.select) {
      throw const FormatException('Invalid input type');
    }
    switch (argument.type) {
      case ArgumentType.keyCode:
        return KeyCodes.selectEntries;
      case ArgumentType.static:
      case ArgumentType.text:
        throw const FormatException('Invalid argument type');
    }
  }
}
