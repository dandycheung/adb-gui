import 'package:isar/isar.dart';

part 'automation.g.dart';

@collection
class Automation {
  Id id = Isar.autoIncrement;
  late String name;
  late List<Command> commands;
}

@embedded
class Command {
  @Enumerated(EnumType.name)
  late CommandType type;
  late Operation operation;
}

@embedded
class Operation {
  @Enumerated(EnumType.name)
  late OperationType type;
  late List<Argument> arguments;
}

@embedded
class Argument {
  @Enumerated(EnumType.name)
  late ArgumentType type;
  @Enumerated(EnumType.name)
  late InputType inputType;
  late String value;
}

enum ArgumentType {
  keyCode(label: 'Key code'),
  static(label: 'Static'),
  text(label: 'Text');

  final String label;

  const ArgumentType({required this.label});
}

enum CommandType {
  adb(label: 'ADB', command: 'adb');

  final String label;
  final String command;

  const CommandType({required this.label, required this.command});
}

enum InputType { select, static, text }

enum OperationType {
  keyboardInput(label: 'Send keyboard input'),
  keyCode(label: 'Send key code'),
  reboot(label: 'Reboot');

  final String label;

  const OperationType({required this.label});
}
