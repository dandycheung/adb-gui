class Device {
  final String address;
  final String? port;

  Device(this.address, this.port);

  @override
  bool operator ==(Object other) =>
      other is Device && other.address == address && other.port == port;

  @override
  int get hashCode => Object.hash(address, port);
}
