import 'dart:io';

// Create theme file
/// Creates the `injection_container.dart` file with a basic
/// [ServiceLocator] that registers [Dio] and [ApiProvider] with [GetIt].
///
/// The generated file is a [StatefulWidget] with an empty [MaterialApp] and has
/// a listener on the [themeManager] to update the theme when the user changes
/// the system theme.
///
/// The generated file also prints a message to the console when it is created.
///
/// The file is written to the `lib` directory of the current working directory.
Future<void> createInjectionContainer() async {
  File('lib/injection_container.dart').writeAsStringSync('''
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/api_provider.dart';

final GetIt getIt = GetIt.instance;

// how to use
// ignore: slash_for_doc_comments
/**
 * Future.wait([
    ServiceLocator().setup(),
    ]).then((value) {
    runApp(const App());
    });
 * **/
class ServiceLocator {
  Future<void> setup() async {
    getIt.registerFactory(() => Dio());
    getIt.registerFactory(() => ApiProvider(getIt()));
  }
}
''');

  print('Created injection_container.dart');
}
