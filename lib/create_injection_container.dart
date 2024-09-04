import 'dart:io';

// Create theme file
Future<void> createInjectionContainer() async {
  File('lib/injection_container.dart').writeAsStringSync('''
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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

  }
}

''');

  print('Created injection_container.dart');
}
