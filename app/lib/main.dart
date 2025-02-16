import 'package:flutter/material.dart';

import 'app.dart';
import 'util/singleton_registry.dart';

void main() {
  SingletonRegistry.register();
  runApp(const App());
}
