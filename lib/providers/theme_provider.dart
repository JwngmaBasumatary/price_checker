import 'package:flutter/material.dart';
import 'package:price_tracker/services/shared_preferences_storage.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      SharedPreferenceStorage.saveTheme("dark");
    } else {
      themeMode = ThemeMode.light;
      SharedPreferenceStorage.saveTheme("light");
    }

    notifyListeners();
  }
}
