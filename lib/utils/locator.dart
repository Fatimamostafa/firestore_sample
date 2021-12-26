import 'package:get_it/get_it.dart';
import 'package:glint_test/utils/navigation_service.dart';

GetIt locator = GetIt.instance;


/// Setup singleton for navigation router service
Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}
