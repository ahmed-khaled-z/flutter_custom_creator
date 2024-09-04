import 'dart:io';


createMainFile() {
  File('lib/main.dart').writeAsStringSync('''
// lib/main.dart
import 'package:flutter/material.dart';

import 'app.dart';
import 'injection_container.dart';

import 'config/theme/theme_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  themeManager = await ThemeManager.loadTheme();

  Future.wait([
    ServiceLocator().setup(),
  ]).then((value) {
    runApp(App());
  });

}

''');
print('Created main.dart');
}