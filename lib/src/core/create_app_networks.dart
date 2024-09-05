import 'dart:async';
import 'dart:io';

// Create theme file
/// Creates the `lib/core/network` directory and its contents, such as
/// `api_provider.dart` and `app_endpoints.dart`.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
Future<void> createAppNetwork() async {
  Directory('lib/core/network').createSync(recursive: true);
  await createApiProvider();
  await createAppEndboits();
}



  /// Creates the `api_provider.dart` file with a class `ApiProvider` that has
  /// a single method `requestAPI` that sends a request to the given [url]
  /// with the given [body] and [headers].
  ///
  /// The `requestAPI` method returns a `Future` that resolves to the response
  /// data if the response status code is 200, 201, 204, or 206. Otherwise, it
  /// throws an exception with the error message from the response data.
  ///
  /// The `requestAPI` method also adds the following headers to the request:
  ///
  /// * `Content-Type`: `application/json`
  ///
  /// The `requestAPI` method does not throw any errors; it prints a success
  /// message to the console when it is completed.
  ///
  /// The file is written to the `lib/core/network` directory of the current
  /// working directory.
createApiProvider() {
  File('lib/core/network/api_provider.dart').writeAsStringSync('''
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../config/app_helper/app_extension.dart';

enum RequestType { post, get, put, delete }

class ApiProvider {
  final Dio _dio;

  ApiProvider(this._dio);

  Future<dynamic> requestAPI({
    required String url,
    dynamic body,
    required Map<String, String> headers,
    RequestType type = RequestType.post,
  }) async {
    headers.addAll({});

    try {
      var response = await _dio.request(
        url,
        options: Options(
          method: type.name.capitalize(),
          headers: headers,
        ),
        data: body,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204 ||
          response.statusCode == 206) {
        return response.data;
      } else {
        Map data = response.data;
        throw Exception(data['message'] ?? 'error from server');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('please check internet connection');
      } else if (e.type == DioExceptionType.unknown &&
          e.error is SocketException) {
        throw Exception('please check internet connection');
      } else if (e.response != null) {
        Map data = e.response?.data;
        var message = data['error']['message'] ?? 'an error occurred';
        throw Exception(message);
      } else {
        rethrow;
      }
    }
  }
}
''');
}

/// Creates the `app_endpoints.dart` file with a single class `AppEndpoints`
/// containing a single static string field `baseUrl` set to a default value
/// of 'https://jsonplaceholder.typicode.com/'
///
/// The generated file also contains a single static field `getPosts` which
/// is set to the value of `baseUrl` concatenated with the string 'posts'.
///
/// The function is asynchronous and returns a `Future<void>`.
///
/// The function is idempotent; it can be safely called multiple times.
///
/// The function does not throw any errors; it prints a success message to the
/// console when it is completed.
createAppEndboits() {
  File('lib/core/network/app_endpoints.dart').writeAsStringSync('''
final String baseUrl = 'https://jsonplaceholder.typicode.com/';

class AppEndpoints{
static String getPosts = baseUrl + 'posts';
}
''');
}
