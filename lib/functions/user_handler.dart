import 'dart:convert';

import 'package:lenden/config/StorageService.dart';
import 'package:lenden/functions/core/user_model.dart';

class UserHandler {
  static const String _dataName = 'userData';
  static final StorageService _storageService = StorageService();

  static Future<void> saveUserData(UserStoreModel data) async {
    await _storageService.saveData(_dataName, jsonEncode(data.toMap()));
  }

  static Future<UserStoreModel?> getUserData() async {
    String? data = await _storageService.getData(_dataName);
    UserStoreModel? user;
    if (data != null) {
      Map<String, dynamic> mapData = jsonDecode(data);
      user = UserStoreModel.fromMap(mapData);
    }
    return user;
  }
}
