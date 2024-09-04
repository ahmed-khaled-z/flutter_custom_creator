import 'dart:io';

// Create theme file
Future<void> createAppFile() async {
  File('lib/app.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'config/theme/theme_manager.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeManager.addListener(_updateTheme);
  }

  @override
  void dispose() {
    themeManager.removeListener(_updateTheme);
    super.dispose();
  }

  void _updateTheme() {
    setState(() {}); // Rebuild the widget when the theme changes
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeManager.themeData,
      home: Container(),
    );
  }
}
''');

  print('Created app.dart');
}
