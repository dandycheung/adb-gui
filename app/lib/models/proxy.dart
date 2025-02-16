import 'package:isar/isar.dart';

part 'proxy.g.dart';

@collection
class Proxy {
  Id id = Isar.autoIncrement;
  @Enumerated(EnumType.name)
  late ProxyType type;
  late Socket from;
  late Socket to;

  @override
  String toString() {
    return '${type.typeName} ${from.type.typeName}:${from.name} ${to.type.typeName}:${to.name}';
  }
}

enum ProxyType {
  forward(typeName: 'forward'),
  reverse(typeName: 'reverse');

  final String typeName;

  const ProxyType({required this.typeName});
}

@embedded
class Socket {
  @Enumerated(EnumType.name)
  late SocketType type;
  late String name;

  @override
  bool operator ==(Object other) {
    return other is Socket && type == other.type && name == other.name;
  }

  @override
  int get hashCode => Object.hash(type, name);

  Socket copy({SocketType? type, String? name}) {
    return Socket()
      ..type = type ?? this.type
      ..name = name ?? this.name;
  }

  static Socket fromString(String input) {
    List<String> parts = input.split(':');
    return Socket()
      ..type = SocketType.values.byName(parts.first)
      ..name = parts.sublist(1).join(' ');
  }
}

enum SocketType {
  acceptFd(typeName: 'acceptfd', proxyTypes: [ProxyType.forward]),
  dev(typeName: 'dev', proxyTypes: [ProxyType.forward]),
  jdwp(typeName: 'jdwp', proxyTypes: [ProxyType.forward]),
  localAbstract(
    typeName: 'localabstract',
    proxyTypes: [ProxyType.forward, ProxyType.reverse],
  ),
  localFileSystem(
    typeName: 'localfilesystem',
    proxyTypes: [ProxyType.forward, ProxyType.reverse],
  ),
  localReserved(
    typeName: 'localreserved',
    proxyTypes: [ProxyType.forward, ProxyType.reverse],
  ),
  tcp(typeName: 'tcp', proxyTypes: [ProxyType.forward, ProxyType.reverse]),
  vsock(typeName: 'vsock', proxyTypes: [ProxyType.forward]);

  final String typeName;
  final List<ProxyType> proxyTypes;

  const SocketType({required this.typeName, required this.proxyTypes});
}
