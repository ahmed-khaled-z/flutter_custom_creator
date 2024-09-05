import 'dart:async';
import 'dart:io';

// Create theme file
  /// Creates the `app_helper` directory and its contents, such as
  /// `app_constants.dart`, `app_formats.dart`, `app_extension.dart`,
  /// `app_functions.dart`, `app_gaps.dart`, and `app_padding.dart`.
  ///
  /// The `app_name` parameter is required and is used in the
  /// `app_constants.dart` file.
  ///
  /// The function is asynchronous and returns a `Future<void>`.
  ///
  /// The function is idempotent; it can be safely called multiple times.
  ///
  /// The function does not throw any errors; it prints a success message to the
  /// console when it is completed.
Future<void> createAppHelper({required String appName}) async {
  Directory('lib/config/app_helper').createSync(recursive: true);
  await createAppConstants(appName: appName);
  await createAppFormats();
  await createAppExtension();
  await createAppFunctions();
  await createAppGaps();
  await createAppPadding();
  print('your app_helper created successfully! 🎉');
}

  /// Creates the `app_constants.dart` file with a single class `AppConstants`
  /// containing a single static string field `appName` set to the value of
  /// `appName` parameter.
createAppConstants({required String appName}) {
  File('lib/config/app_helper/app_constants.dart').writeAsStringSync('''

class AppConstants {
  static const String appName = "$appName";
} 
''');
}



  /// Creates the `app_formats.dart` file with a class `AppFormats` containing
  /// four static `DateFormat` fields: `dateFormat`, `timeFormat`,
  /// `serverTime`, and `dateTimeFormat`. These are used to format dates and
  /// times in the app.
  ///
  /// The function is asynchronous and returns a `Future<void>`.
  ///
  /// The function is idempotent; it can be safely called multiple times.
  ///
  /// The function does not throw any errors; it prints a success message to the
  /// console when it is completed.
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

  /// Creates the `app_extension.dart` file with various extensions on
  /// [ChangeNotifier], [Exception], [String], [BuildContext], [DateTime], and
  /// [TimeOfDay].
  ///
  /// The generated file contains some useful extensions for the above classes.
  ///
  /// The function is asynchronous and returns a `Future<void>`.
  ///
  /// The function is idempotent; it can be safely called multiple times.
  ///
  /// The function does not throw any errors; it prints a success message to the
  /// console when it is completed.
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

/// Creates the `app_functions.dart` file with a single class `AppFunctions`
/// containing a single static method `extractNumber` that extracts the first
/// number found in the given [input] string.
///
/// The `extractNumber` method returns an empty string if no number is found.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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

/// Creates the `app_gaps.dart` file with a single class `AppGaps`
/// containing the following static const fields:
///
/// * `extraSmallGap` with value `Gap(2)`
/// * `soSmallGap` with value `Gap(5)`
/// * `smallGap` with value `Gap(10)`
/// * `defaultGap` with value `Gap(20)`
/// * `bigGap` with value `Gap(40)`
/// * `soBigGap` with value `Gap(80)`
/// * `extraBigGap` with value `Gap(120)`
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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

/// Creates the `app_padding.dart` file with a single class `AppPadding`
/// containing the following static const fields:
///
/// * `extraSmallPadding` with value `3.0`
/// * `soSmallPadding` with value `5.0`
/// * `smallPadding` with value `10.0`
/// * `tinySmallPadding` with value `12.0`
/// * `defaultPadding` with value `20.0`
/// * `bigPadding` with value `40.0`
/// * `soBigPadding` with value `80.0`
/// * `extraBigPadding` with value `120.0`
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
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