import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:deptech_test/core/utils/background/backgorund_service_utils.dart';

class ScheduleUtils {
  void setSchedule(String time, int id) async {
    print("=====> Jadwalin Bos");
    AndroidAlarmManager.periodic(
      const Duration(seconds: 1),
      id,
      BackgroundServiceUtils.callback,
      startAt: DateTime.now().add(Duration(seconds: 5)),
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
    );
  }

  void deleteSchedule(int id) {
    AndroidAlarmManager.cancel(id);
  }
}