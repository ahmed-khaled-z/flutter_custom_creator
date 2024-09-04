import 'dart:io';
import 'package:flutter_custom_creator/create_injection_container.dart';
import 'package:flutter_custom_creator/create_router.dart';
import 'package:flutter_custom_creator/create_theme_file.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'create_app_file.dart';
import 'create_main_file.dart';
import 'create_app_helper.dart';

Future<void> createCustomProject(
    String projectName, String organization) async {
  // Run flutter create
  await Process.run('flutter', ['create', '--org', organization, projectName],
      runInShell: true);

  // Change to the new project directory
  Directory.current = Directory(projectName);

  // Add dependencies
  await addDependencies();

  // Create custom directories
  await creatDirectorys();

  // Modify pubspec.yaml to add assets
  await addAssets();

  // Create custom files
  await createCustomFiles();

  print('yor project "$projectName" created successfully! 🎉');
}

Future<void> addDependencies() async {
  var result = await Process.run(
      'flutter',
      [
        'pub',
        'add',
        'dio',
        'clean_architecture_with_state_management',
        'shared_preferences',
        'intl',
        'gap',
        'get_it',
      ],
      runInShell: true);
  print(result.stdout);
}

Future<void> createCustomFiles() async {
  // Create main.dart with theme
  await createMainFile();

  // Create app.dart
  await createAppFile();

  // Create injection_container.dart
  await createInjectionContainer();

  // Create theme file
  await createThemeFiles();

  // Create app_helper.dart
  await createAppHelper();

  // Create router.dart
  await createRouter();
}

/// Adds the following assets to the pubspec.yaml:
///
/// * `assets/images/`
/// * `assets/fonts/`
///
/// This is a convenience function to simplify the process of adding assets
/// to a Flutter project.
Future<void> addAssets() async {
  Directory('assets').createSync(recursive: true);
  Directory('assets/images').createSync(recursive: true);
  Directory('assets/fonts').createSync(recursive: true);
  Directory('assets/icons').createSync(recursive: true);
  Directory('assets/jsons').createSync(recursive: true);
  Directory('assets/logo').createSync(recursive: true);
  Directory('assets/translations').createSync(recursive: true);

  

  var pubspecFile = File('pubspec.yaml');
  var content = pubspecFile.readAsStringSync();
  var yamlEditor = YamlEditor(content);

  yamlEditor.update([
    'flutter',
    'assets'
  ], [
    'assets/images/',
    'assets/fonts/',
    'assets/icons/',
    'assets/jsons/',
    'assets/logo/',
    'assets/translations/',
  ]);

  pubspecFile.writeAsStringSync(yamlEditor.toString());
}

Future<void> creatDirectorys() async {
//Create directories
  Directory('lib/config').createSync(recursive: true);
  Directory('lib/core').createSync(recursive: true);
  Directory('lib/features').createSync(recursive: true);
}
