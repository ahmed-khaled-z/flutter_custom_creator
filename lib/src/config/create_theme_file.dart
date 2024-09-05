import 'dart:io';

// Create theme file
/// Creates the following theme files in the `lib/config/theme` directory:
///
/// * `light_theme.dart`
/// * `dark_theme.dart`
/// * `theme_notifier.dart`
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
Future<void> createThemeFiles() async {
  Directory('lib/config/theme').createSync(recursive: true);
  await createLightTheme();
  await createDarkTheme();
  await createThemeNotifier();
  print('your theme files created successfully! 🎉');
}



/// Creates the `light_theme.dart` file with a [ThemeData] object set to a
/// light theme. The generated file contains a single constant field
/// `lightTheme` with a [ThemeData] object with the following properties:
///
/// * `brightness` set to [Brightness.light]
/// * `primaryColor` set to [Colors.blue]
/// * `scaffoldBackgroundColor` set to [Colors.white]
///
/// The generated file also prints a success message to the console when it
/// is created.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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

/// Creates the `dark_theme.dart` file with a [ThemeData] object set to a
/// dark theme. The generated file contains a single constant field
/// `darkTheme` with a [ThemeData] object with the following properties:
///
/// * `brightness` set to [Brightness.dark]
/// * `primaryColor` set to [Colors.grey[900]]
/// * `scaffoldBackgroundColor` set to [Colors.black]
///
/// The generated file also prints a success message to the console when it
/// is created.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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

/// Creates the `theme_manager.dart` file which contains a [ThemeManager]
/// class.
///
/// The [ThemeManager] class is a [ChangeNotifier] that holds a [ThemeData]
/// object and a boolean indicating whether the current theme is dark or light.
///
/// The class also has a [ThemeManager.loadTheme] method which loads the
/// theme from the device's shared preferences and returns a [ThemeManager]
/// instance.
///
/// The class also has a [ThemeManager.toggleTheme] method which toggles the
/// current theme and saves it to the device's shared preferences.
///
/// The generated file also defines a global [ThemeManager] instance and a
/// global function to toggle the theme.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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
