import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('Request: [${options.method}] ${options.uri}');
    log('Headers: ${options.headers}');
    log('Body: ${options.data}');

    if (options.headers['requiresToken'] == true) {
      final preferences = await SharedPreferences.getInstance();
      final authToken = preferences.getString('accessToken');
      if (authToken != null) {
        options.headers.remove('requiresToken'); // Clean up the header flag
        options.headers.addAll({"Authorization": "Bearer $authToken"});
      }
    }

    return handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('Response: ${response.data} & ${response.statusCode}');
    return handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    log('Error: ${err.message}');
    if (err.response != null) {
      log('Error Response: ${err.response?.data}');
    }
    return handler.next(err);
  }
}
