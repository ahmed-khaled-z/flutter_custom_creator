import 'dart:async';
import 'dart:io';

// Create theme file
Future<void> createAppHelper() async {
  Directory('lib/config/app_helper').createSync(recursive: true);
  await createAppFormats();
  await createAppExtension();
  await createAppFunctions();
  await createAppGaps();
  await createAppPadding();
  print('your app_helper created successfully! 🎉');
}



createAppFormats() {
  File('lib/config/app_helper/app_formats.dart').writeAsStringSync('''
import 'package:intl/intl.dart';

class AppFormats {
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static DateFormat timeFormat = DateFormat("hh:mm a");
  static DateFormat serverTime = DateFormat("HH:mm:ss");
  static DateFormat dateTimeFormat = DateFormat("dd-MMMM-yyyy hh:mm a");
  static DateFormat format = DateFormat('dd-MM-yyyy hh:mm a');
}

''');
}

createAppExtension() {
  File('lib/config/app_helper/app_extension.dart').writeAsStringSync('''
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_formats.dart';

extension LoadingExtension on ChangeNotifier {
  static bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    notifyListeners();
  }
}

extension ExceptionExtension on Exception {
  String get message {
    try {
      return (this as dynamic).message;
    } catch (_) {
      return toString();
    }
  }
}

extension StringExtension on String {
  void printMe() {
    if (kDebugMode) {
      print(this);
    }
  }

  String capitalize() => '\${this[0].toUpperCase()}\${substring(1)}';

  String smallLength({int maxLength = 10}) =>
      length > maxLength ? '\${substring(0, maxLength)}...' : this;

  Map<String, dynamic> toMap() => jsonDecode(this);

  String toJson() => jsonEncode(toMap());
}

extension ContextExtensions on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  /// The same of [MediaQuery.of(context).size]
  ThemeData get theme => Theme.of(this);

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;
}

extension DateTimeExtension on DateTime {
  String get dateTimeFormat => AppFormats.dateTimeFormat.format(this);
  String get dateFormat => AppFormats.dateFormat.format(this);
  String get timeFormat => AppFormats.timeFormat.format(this);
  String get format => AppFormats.format.format(this);
}

extension TimeOfDayExtension on TimeOfDay {
  DateTime get timeOfDayToDate => DateTime(0, 0, 0, hour, minute);
}

''');
}

createAppFunctions() {

  File('lib/config/app_helper/app_functions.dart').writeAsStringSync('''

class AppFunctions {
  /// Extracts the first number found in the given [input] string.
  ///
  /// Returns an empty string if no number is found.
  ///
  /// Example:
  ///   extractNumber('abc123def456') // '123'
  static String extractNumber(String input) {
    RegExp regExp = RegExp(r'\\d+');
    String? number = regExp.firstMatch(input)?.group(0);
    return number ?? ''; // Return an empty string if no number is found
  }
}

''');
}

createAppGaps() {
  File('lib/config/app_helper/app_gaps.dart').writeAsStringSync('''
import 'package:gap/gap.dart';

class AppGaps{
  static const extraSmallGap = Gap(2);
  static const soSmallGap = Gap(5);
  static const smallGap = Gap(10);
  static const defaultGap = Gap(20);
  static const bigGap = Gap(40);
  static const soBigGap = Gap(80);
  static const extraBigGap = Gap(120);
}
''');
}

createAppPadding() {
  File('lib/config/app_helper/app_padding.dart').writeAsStringSync('''
class AppPadding {
  static const extraSmallPadding = 3.0;
  static const soSmallPadding = 5.0;
  static const smallPadding = 10.0;
  static const tinySmallPadding = 12.0;
  static const defaultPadding = 20.0;
  static const bigPadding = 40.0;
  static const soBigPadding = 80.0;
  static const extraBigPadding = 120.0;
}

''');
}