import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static late SharedPreferences _prefs;

  static const _isLoggedInKey = 'isLoggedIn';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn({required bool value}) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }
}
