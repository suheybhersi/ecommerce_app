import 'package:ecommerce_app/themes/dark_mode.dart';
import 'package:ecommerce_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData == lightMode ? themeData = darkMode : themeData = lightMode;
  }
}
