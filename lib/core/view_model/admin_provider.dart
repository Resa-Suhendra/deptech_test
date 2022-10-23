import 'dart:convert';

import 'package:deptech_test/core/model/admin/admin_model.dart';
import 'package:deptech_test/core/utils/storage/local_database_utils.dart';
import 'package:deptech_test/core/utils/storage/local_storage_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// Detail of admin model
  AdminModel? _adminModel;

  AdminModel? get adminModel => _adminModel;

  bool _isLoadingLogin = false;

  bool get isLoadingLogin => _isLoadingLogin;

  // String? _imageProfile;
  //
  // String? get imageProfile => _imageProfile;

  void setLoadingLogin(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  final dbHelper = LocalDatabaseUtils.instance;

  void setImageProfile(String value) async {
    var res = await dbHelper.updateImageAdmin(value);
    print(" Result Upd : $res");
    if (res != null && res > 0) {
      getAdminData();
      notifyListeners();
    }
  }

  Future<AdminModel?> loginAdmin(String email, String password) async {
    List<Map<String, dynamic>> res = await dbHelper.loginAdmin(email, password);

    if (res.isNotEmpty) {
      _adminModel = AdminModel.fromJson(res[0]);
      localStorageUtil.saveLoginSession();
      notifyListeners();
      return adminModel;
    }

    return null;
  }

  Future<int?> updateProfile(AdminModel data) async {
    int? res = await dbHelper.updateProfileAdmin(data);
    getAdminData();
    return res;
  }

  void getAdminData() async {
    List<Map<String, dynamic>> res =
        await dbHelper.queryAllData(LocalDatabaseUtils.tableAdmin);
    _adminModel = AdminModel.fromJson(res[0]);
    notifyListeners();
  }

  Image imageFromBase64String() {
    return Image.memory(
      base64Decode(_adminModel!.profileImage!),
      fit: BoxFit.cover,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
