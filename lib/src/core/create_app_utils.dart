import 'dart:async';
import 'dart:io';

// Create theme file
/// Creates the `lib/core/utils` directory and its contents, such as
/// `app_logger.dart`, `app_validator.dart`, `snack_bar_utils.dart`, and
/// `app_dialogs.dart`.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
Future<void> createAppUtils() async {
  Directory('lib/core/utils').createSync(recursive: true);
  await createAppLogger();
  await createAppValidator();
  await createSnackBarUtils();
  await createAppDialogs();
}

  /// Creates the `logger.dart` file with a class `Logger` containing four
  /// static methods to print a message in the console with different colors.
  ///
  /// The `Logger` class is a simple logging utility that writes to the
  /// console with different colors based on the log type.
  ///
  /// The `info` method prints a message with a blue color.
  ///
  /// The `success` method prints a message with a green color.
  ///
  /// The `warning` method prints a message with a yellow color.
  ///
  /// The `error` method prints a message with a red color.
  ///
  /// The generated file also contains a private static method `_log` which
  /// takes the message, color, and log type as parameters and prints the
  /// message with the specified color and log type.
  ///
  /// The generated file also contains a helper function `_splitMessageIntoLines`
  /// which splits a message into lines of a specified length.
  ///
  /// The function is asynchronous and returns a `Future<void>`.
  ///
  /// The function is idempotent; it can be safely called multiple times.
  ///
  /// The function does not throw any errors; it prints a success message to
  /// the console when it is completed.
createAppLogger() {
  File('lib/core/utils/logger.dart').writeAsStringSync('''
import 'package:flutter/foundation.dart';

class Logger {
  static const String _reset = '\\x1B[0m';
  static const String _red = '\\x1B[31m';
  static const String _green = '\\x1B[32m';
  static const String _yellow = '\\x1B[33m';
  static const String _blue = '\\x1B[34m';

  static const int _maxLineLength = 80; // Adjust based on your console width

  // Log types
  static void info(String message) {
    _log(message, _blue, 'INFO');
  }

  static void success(String message) {
    _log(message, _green, 'SUCCESS');
  }

  static void warning(String message) {
    _log(message, _yellow, 'WARNING');
  }

  static void error(String message) {
    _log(message, _red, 'ERROR');
  }

  // Private log function
  static void _log(String message, String color, String type) {
    if (kDebugMode) {
      // Split the message into lines that fit within the console width
      List<String> lines = _splitMessageIntoLines(message);

      String border = '*' * (_maxLineLength + 10);
      String formattedMessage = '\$color\$border\\n';

      for (String line in lines) {
        formattedMessage += '*  \$line\${' ' * (_maxLineLength - line.length)}  *\\n';
      }

      formattedMessage += '\$border\$_reset';
      print(formattedMessage);
    }
  }

  // Helper function to split a message into lines of _maxLineLength
  static List<String> _splitMessageIntoLines(String message) {
    List<String> lines = [];
    for (int i = 0; i < message.length; i += _maxLineLength) {
      lines.add(message.substring(i, i + _maxLineLength > message.length ? message.length : i + _maxLineLength));
    }
    return lines;
  }
}

''');
}

  /// Creates the `validator.dart` file with a class `Validator` containing
  /// methods to validate user input. The methods are:
  ///
  /// * `isNotEmpty` to check if a string is not empty
  /// * `isValidEmail` to validate an email address
  /// * `hasMinLength` to check if a string has a minimum length
  /// * `hasMaxLength` to check if a string has a maximum length
  /// * `isNumeric` to check if a string is a valid number
  /// * `isValidPhone` to validate a phone number (basic validation)
  /// * `isValidPassword` to validate a password (minimum 8 characters, at least one letter and one number)
  /// * `doPasswordsMatch` to check if two passwords match
  ///
  /// The generated file contains some useful static methods to validate
  /// user input. The methods are idempotent; it can be safely called multiple
  /// times. The methods do not throw any errors; it returns a `String?` with
  /// the error message if the validation fails, or `null` if the validation
  /// succeeds.
createAppValidator() {
  File('lib/core/utils/validator.dart').writeAsStringSync('''
class Validator {
  // Check if a string is empty
  static String? isNotEmpty(String? value, {String message = 'Field cannot be empty'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  // Validate email format
  static String? isValidEmail(String? value, {String message = 'Invalid email address'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email cannot be empty';
    }
    String pattern = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}\$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  // Check if a string has a minimum length
  static String? hasMinLength(String? value, int minLength, {String message = ''}) {
    message = message.isEmpty ? 'Minimum length is \$minLength characters' : message;
    if (value == null || value.length < minLength) {
      return message;
    }
    return null;
  }

  // Check if a string has a maximum length
  static String? hasMaxLength(String? value, int maxLength, {String message = ''}) {
    message = message.isEmpty ? 'Maximum length is \$maxLength characters' : message;
    if (value != null && value.length > maxLength) {
      return message;
    }
    return null;
  }

  // Validate if the value is a valid number
  static String? isNumeric(String? value, {String message = 'Value must be a number'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    if (double.tryParse(value) == null) {
      return message;
    }
    return null;
  }

  // Validate phone number (basic validation)
  static String? isValidPhone(String? value, {String message = 'Invalid phone number'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }
    String pattern = r'^\\+?[0-9]{7,15}\$'; // Matches phone numbers with 7 to 15 digits, optional "+" at start
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  // Validate password (minimum 8 characters, at least one letter and one number)
  static String? isValidPassword(String? value, {String message = 'Password must be at least 8 characters long, contain at least one letter and one number'}) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    String pattern = r'^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  // Check if two passwords match
  static String? doPasswordsMatch(String? password, String? confirmPassword, {String message = 'Passwords do not match'}) {
    if (password != confirmPassword) {
      return message;
    }
    return null;
  }
}

''');
}

  /// Creates the `snack_bar_utils.dart` file with a [SnackBarUtils] class
  /// containing methods to show a custom [SnackBar] with optional action
  /// and custom colors. The generated file also contains utility methods
  /// to show error, info, success, loading, and warning snackbars, and a
  /// method to dismiss any active snackbar.
createSnackBarUtils() {
  File('lib/core/utils/snack_bar_utils.dart').writeAsStringSync('''
// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import '../../config/router/app_router.dart';


class SnackBarUtils {
  static const Duration _defaultDuration = Duration(seconds: 3);

  // Show a custom SnackBar with optional action
  static void showSnackBar({
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = _defaultDuration,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Color actionColor = Colors.blueAccent,
  }) {
    final context = AppRouter.currentContext;

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: textColor),
          ),
          backgroundColor: backgroundColor,
          duration: duration,
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                  textColor: actionColor,
                )
              : null,
        ),
      );
    } else {
      // Handle the case where context is null (optional)
      print('Error: Context is null, cannot show SnackBar.');
    }
  }

  // Show an error SnackBar
  static void showError(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }

  // Show an info SnackBar
  static void showInfo(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
    );
  }

  // Show a success SnackBar
  static void showSuccess(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.white,
    );
  }

  // Show a loading SnackBar (with indefinite duration)
  static void showLoading(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      duration: const Duration(hours: 1), // long duration for loading
    );
  }

  // Show a warning SnackBar
  static void showWarning(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
    );
  }

  // Dismiss any active SnackBar (optional utility)
  static void dismissSnackBar() {
    final context = AppRouter.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } else {
      print('Error: Context is null, cannot dismiss SnackBar.');
    }
  }
}

''');
}

/// Creates the `app_dialogs.dart` file with a single class `DialogUtils`
/// containing methods to show various dialogs, such as a custom dialog,
/// error dialog, info dialog, success dialog, warning dialog, loading dialog,
/// and confirmation dialog.
///
/// The generated file also contains some utility methods to dismiss any
/// active dialog.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
createAppDialogs() {
  File('lib/core/utils/dialogs.dart').writeAsStringSync('''
// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import '../../config/router/app_router.dart';


class DialogUtils {
  // Show a custom dialog
  static void showDialogBox({
    required String title,
    required String message,
    String? positiveButtonLabel,
    VoidCallback? onPositiveButtonPressed,
    String? negativeButtonLabel,
    VoidCallback? onNegativeButtonPressed,
    bool dismissible = true,
    Color titleColor = Colors.black,
    Color messageColor = Colors.black87,
    Color backgroundColor = Colors.white,
    Color positiveButtonColor = Colors.blueAccent,
    Color negativeButtonColor = Colors.redAccent,
  }) {
    final context = AppRouter.currentContext;

    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: Text(
              title,
              style: TextStyle(color: titleColor),
            ),
            content: Text(
              message,
              style: TextStyle(color: messageColor),
            ),
            actions: <Widget>[
              if (negativeButtonLabel != null)
                TextButton(
                  child: Text(
                    negativeButtonLabel,
                    style: TextStyle(color: negativeButtonColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onNegativeButtonPressed != null) {
                      onNegativeButtonPressed();
                    }
                  },
                ),
              if (positiveButtonLabel != null)
                TextButton(
                  child: Text(
                    positiveButtonLabel,
                    style: TextStyle(color: positiveButtonColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onPositiveButtonPressed != null) {
                      onPositiveButtonPressed();
                    }
                  },
                ),
            ],
          );
        },
      );
    } else {
      // Handle the case where context is null (optional)
      print('Error: Context is null, cannot show dialog.');
    }
  }

  // Show an error dialog
  static void showErrorDialog(String message, {String title = 'Error'}) {
    showDialogBox(
      title: title,
      message: message,
      positiveButtonLabel: 'OK',
      titleColor: Colors.redAccent,
    );
  }

  // Show an info dialog
  static void showInfoDialog(String message, {String title = 'Info'}) {
    showDialogBox(
      title: title,
      message: message,
      positiveButtonLabel: 'OK',
      titleColor: Colors.blueAccent,
    );
  }

  // Show a success dialog
  static void showSuccessDialog(String message, {String title = 'Success'}) {
    showDialogBox(
      title: title,
      message: message,
      positiveButtonLabel: 'OK',
      titleColor: Colors.greenAccent,
    );
  }

  // Show a warning dialog
  static void showWarningDialog(String message, {String title = 'Warning'}) {
    showDialogBox(
      title: title,
      message: message,
      positiveButtonLabel: 'OK',
      titleColor: Colors.orangeAccent,
    );
  }

  // Show a loading dialog with a CircularProgressIndicator
  static void showLoadingDialog({String message = 'Loading...'}) {
    final context = AppRouter.currentContext;

    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          );
        },
      );
    } else {
      print('Error: Context is null, cannot show loading dialog.');
    }
  }

  // Show a confirmation dialog
  static void showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirmed,
    VoidCallback? onCancelled,
    String confirmLabel = 'Yes',
    String cancelLabel = 'No',
    Color confirmButtonColor = Colors.blueAccent,
    Color cancelButtonColor = Colors.redAccent,
    bool dismissible = true,
  }) {
    showDialogBox(
      title: title,
      message: message,
      positiveButtonLabel: confirmLabel,
      onPositiveButtonPressed: onConfirmed,
      negativeButtonLabel: cancelLabel,
      onNegativeButtonPressed: onCancelled,
      dismissible: dismissible,
      positiveButtonColor: confirmButtonColor,
      negativeButtonColor: cancelButtonColor,
    );
  }

  // Dismiss any active dialog (optional utility)
  static void dismissDialog() {
    final context = AppRouter.currentContext;
    if (context != null) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      print('Error: Context is null, cannot dismiss dialog.');
    }
  }
}

''');
}
