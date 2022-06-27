import 'package:get_it/get_it.dart';
import 'package:scheduleapp/core/services/dio_services_API.dart';
import 'package:scheduleapp/core/themes/colors.dart';

GetIt locator = GetIt.instance;

void serviceLocators() {
  locator.registerLazySingleton<ColorSchemes>(() => ColorSchemes());
  locator.registerLazySingleton<DioAPIServices>(() => DioAPIServices());
}
