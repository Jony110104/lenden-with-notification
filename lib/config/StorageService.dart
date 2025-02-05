import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
