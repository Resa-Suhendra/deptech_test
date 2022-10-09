import 'package:deptech_test/core/utils/storage/local_storage_utils.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/navigation/navigation_utils.dart';

GetIt locator = GetIt.instance;


Future<void> setupLocator() async {

  /// Registering api
  // if (locator.isRegistered(instance: Api()) == false) {
  //   locator.registerSingleton(Api());
  // }
  // if (locator.isRegistered(instance: BaseAPI()) == false) {
  //   locator.registerSingleton(BaseAPI());
  // }

  /// Registering utils
  locator.registerSingleton(NavigationUtils());
  locator.registerSingleton(LocalStorageUtils());
  // locator.registerLazySingleton(() => FavoriteUtils());
  // locator.registerLazySingleton(() => ScheduleUtils());
  // locator.registerLazySingleton(() => NotificationUtils());
  // locator.registerLazySingleton(() => BackgroundServiceUtils());

  /// Registering services
  // locator.registerLazySingleton(() => RestaurantService(
  //     locator<BaseAPI>()
  // ));
}