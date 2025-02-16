import 'package:isar/isar.dart';

part 'emulator.g.dart';

@collection
class Emulator {
  Id id = Isar.autoIncrement;
  late String name;
  late EmulatorParams params;
}

@embedded
class EmulatorParams {
  bool noSnapshotLoad = false;
  bool writeableSystem = false;
}
