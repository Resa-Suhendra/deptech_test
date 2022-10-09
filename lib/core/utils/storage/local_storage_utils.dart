import 'package:deptech_test/injector.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageUtils {
  final LocalStorage _storage = LocalStorage('notes_app');

  void saveLoginSession() async {
    print("===> Save Session Login");

    await _storage.ready;
    await _storage.setItem("is_login", true);
  }

  Future<bool> getLoginSession() async {
    print("===> Get Session Login");

    await _storage.ready;
    var res = await _storage.getItem("is_login");

    print("===> Get Session Login $res");
    if (res != null) {
      return res as bool;
    }
    return false;
  }

  void logout() async {
    await _storage.ready;
    await _storage.clear();
  }
}

final localStorageUtil = locator<LocalStorageUtils>();
