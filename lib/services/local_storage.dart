import 'package:shared_preferences/shared_preferences.dart';

/// Clase que permite grabar información de modo local
class LocalStorage {
  static late SharedPreferences prefs;
  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
