import 'package:isar/isar.dart';

part 'connection.g.dart';

@collection
class Connection {
  Id id = Isar.autoIncrement;
  late String name;
  late String address;
}
