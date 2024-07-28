import 'package:flutter/material.dart';
import 'package:news_app/screen/theme_data.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get currentTheme =>
      _themeMode == ThemeMode.dark ? darkTheme : lightTheme;
}
