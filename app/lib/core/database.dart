import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/automation.dart';
import '../models/connection.dart';
import '../models/emulator.dart';
import '../models/proxy.dart';
import '../models/setting.dart';

Future<Isar> _createDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [
      AutomationSchema,
      ConnectionSchema,
      EmulatorSchema,
      ProxySchema,
      SettingSchema
    ],
    directory: dir.path,
  );
}

final database = _createDatabase();
