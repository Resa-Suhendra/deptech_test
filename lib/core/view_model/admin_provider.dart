import 'package:deptech_test/core/model/admin_model.dart';
import 'package:deptech_test/core/utils/storage/local_database_utils.dart';
import 'package:flutter/foundation.dart';

class AdminProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// Detail of admin model
  AdminModel? _adminModel;

  AdminModel? get adminModel => _adminModel;

  bool _isLoadingLogin = false;

  bool get isLoadingLogin => _isLoadingLogin;

  void setLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  final dbHelper = LocalDatabaseUtils.instance;

  Future<AdminModel?> loginAdmin(String email, String password) async {
    List<Map<String, dynamic>> res = await dbHelper.loginAdmin(email, password);

    if (res.isNotEmpty) {
      _adminModel = AdminModel.fromJson(res[0]);
      _isLoadingLogin = false;
      notifyListeners();
      return adminModel;
    }

    _isLoadingLogin = false;
    return null;
  }
}
