import 'dart:io';

createRouter() async {
  Directory('lib/config/router').createSync(recursive: true);
  await createRouterFile();

  print('your router created successfully! 🎉');
}

createRouterFile() {
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
