import 'package:deptech_test/core/utils/background/backgorund_service_utils.dart';
import 'package:deptech_test/core/utils/notification/notification_utils.dart';
import 'package:deptech_test/core/utils/schedule/schedule_utils.dart';
import 'package:deptech_test/core/utils/storage/local_storage_utils.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/navigation/navigation_utils.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering utils
  locator.registerSingleton(NavigationUtils());
  locator.registerSingleton(LocalStorageUtils());
  locator.registerSingleton(NotificationUtils());
  locator.registerSingleton(ScheduleUtils());
  locator.registerSingleton(BackgroundServiceUtils());
}
