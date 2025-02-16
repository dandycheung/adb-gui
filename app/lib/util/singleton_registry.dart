import 'package:get_it/get_it.dart';

import '../services/automation_service.dart';
import '../services/connection_service.dart';
import '../services/device_service.dart';
import '../services/emulator_service.dart';
import '../services/install_service.dart';
import '../services/keyboard_service.dart';
import '../services/proxy_service.dart';
import '../services/remote_control_service.dart';
import '../services/screenshot_service.dart';
import '../services/setting_service.dart';

class SingletonRegistry {
  static final GetIt _getIt = GetIt.instance;

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }

  static void register() {
    _getIt.registerLazySingleton(() => AutomationService());
    _getIt.registerLazySingleton(() => ConnectionService());
    _getIt.registerLazySingleton(() => DeviceService());
    _getIt.registerLazySingleton(() => EmulatorService());
    _getIt.registerLazySingleton(() => InstallService());
    _getIt.registerLazySingleton(() => KeyboardService());
    _getIt.registerLazySingleton(() => ProxyService());
    _getIt.registerLazySingleton(() => RemoteControlService());
    _getIt.registerLazySingleton(() => ScreenshotService());
    _getIt.registerLazySingleton(() => SettingService());
  }
}
