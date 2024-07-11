import 'package:bootcamp_group_14/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme; // Başlangıç teması

  ThemeProvider() {
    loadThemePreference();
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    saveThemePreference();
  }

  void toggleTheme() {
    themeData = _themeData == lightTheme ? darkTheme : lightTheme;
  }

  Future<void> saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _themeData == darkTheme);
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkTheme =
        prefs.getBool('isDarkTheme') ?? false; // Varsayılan olarak false
    _themeData = isDarkTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
