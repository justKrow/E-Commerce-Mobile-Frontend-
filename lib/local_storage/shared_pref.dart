import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static saveStringValue({required String key, required String value}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return await shp.setString(key, value);
  }

  static Future<String?> getStringValue({required String key}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.getString(key);
  }

  static saveBoolValue({required String key, required bool value}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return await shp.setBool(key, value);
  }

  static Future<bool?> getBoolValue({required String key}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.getBool(key);
  }

  static saveIntValue({required String key, required int value}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return await shp.setInt(key, value);
  }

  static Future<int?> getIntgerValue({required String key}) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.getInt(key);
  }

  static Future<bool> delete(String key) async {
    SharedPreferences shp = await SharedPreferences.getInstance();
    return shp.remove(key);
  }
}
