import 'dart:io';

// Create theme file
Future<void> createThemeFiles() async {
  Directory('lib/config/theme').createSync(recursive: true);
  await createLightTheme();
  await createDarkTheme();
  await createThemeNotifier();
  print('your theme files created successfully! 🎉');
}



createLightTheme() {
  File('lib/config/theme/light_theme.dart').writeAsStringSync('''
// lib/themes/light_theme.dart
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  // Add other properties like AppBarTheme, ButtonTheme, etc.
);
''');
}

createDarkTheme() {
  File('lib/config/theme/dark_theme.dart').writeAsStringSync('''
// lib/themes/dark_theme.dart
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  scaffoldBackgroundColor: Colors.black,
  // Add other properties like AppBarTheme, ButtonTheme, etc.
);

''');
}

createThemeNotifier() {
  File('lib/config/theme/theme_manager.dart').writeAsStringSync('''
// lib/themes/theme_manager.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkTheme;
  ThemeData _themeData;

  ThemeManager(this._isDarkTheme)
      : _themeData = _isDarkTheme ? darkTheme : lightTheme;

  ThemeData get themeData => _themeData;
  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    _themeData = _isDarkTheme ? darkTheme : lightTheme;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  static Future<ThemeManager> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    return ThemeManager(isDarkTheme);
  }
}

// Global instance of ThemeManager
late ThemeManager themeManager;

// Global function to toggle the theme
Future<void> toggleTheme() async {
  themeManager.toggleTheme();
}

''');
}
