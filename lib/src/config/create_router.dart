import 'dart:io';

/// Creates the `router` directory and its contents, such as
/// `unknown_route.dart` and `app_router.dart`.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
createRouter() async {
  Directory('lib/config/router').createSync(recursive: true);
  await createUnknownRouteFile();
  await createAppRouter();

  print('your router created successfully! 🎉');
}

/// Creates the `unknown_route.dart` file which is a [StatelessWidget] that
/// displays a page not found message.
///
/// The generated file contains a single class `UnknownRoute` which is a
/// [StatelessWidget] that displays a page not found message.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
createUnknownRouteFile() async {
  File('lib/config/router/unknown_route.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import '../app_helper/app_extension.dart';

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 150,
            ),
            Text(
              'Page Not Found',
            ),
            Text('You missed your way !!'),
          ],
        ),
      ),
    );
  }
}
''');
}

  /// Creates the `app_router.dart` file with a basic router that uses the
  /// [MaterialApp] and [Navigator] with a global [GlobalKey] to navigate
  /// between routes.
  ///
  /// The generated file contains some useful static methods to navigate
  /// between routes.
  ///
  /// The function is asynchronous and returns a `Future<void>`.
  ///
  /// The function is idempotent; it can be safely called multiple times.
  ///
  /// The function does not throw any errors; it prints a success message to the
  /// console when it is completed.
createAppRouter() async {
  File('lib/config/router/app_router.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'unknown_route.dart';

class AppRouter {
  ///[navigatorKey] is the global NavigatorState key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const Scaffold(), settings: settings);
      default:
        return unknownRoute;
    }
  }

  static BuildContext get currentContext => navigatorKey.currentState!.context;

  static Route get unknownRoute =>
      MaterialPageRoute(builder: (context) => const UnknownRoute());

  //To go back or close snackBars, dialogs, bottomSheets, or anything you would normally close with Navigator.pop(context);
  static void pop(dynamic data) {
    navigatorKey.currentState?.pop(data);
  }

  //Navigate to new screen with name
  static Future<Object?>? to(String route, {Object? data}) async {
    return await navigatorKey.currentState?.pushNamed(route, arguments: data);
  }

  //To go to the next screen and no option to go back to the previous screen
  static Future<Object?>? toReplacement(String route, {Object? data}) async {
    return await navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: data);
  }

  //To go to the next screen and cancel all previous routes
  static Future<Object?>? toAndRemoveUntil(String route, {Object? data}) async {
    return await navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(route, (route) => false, arguments: data);
  }

}

''');
}
