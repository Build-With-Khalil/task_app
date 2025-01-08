import 'package:dio/dio.dart';
import 'package:task_app/core/services/dio/dio_interceptor.dart';

class DioService {
  late Dio dio;

  DioService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://stagingapi.calling-all-kids.com/api",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(DioInterceptor());
  }

  // POST Request
  Future<Response> postRequest(String url, Map<String, dynamic> data,
      {bool requiresToken = false}) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {"requiresToken": requiresToken},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  // GET Request
  Future<Response> getRequest(String url,
      {Map<String, dynamic>? queryParams, bool requiresToken = false}) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {"requiresToken": requiresToken},
        ),
      );
      return response;
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }
}
