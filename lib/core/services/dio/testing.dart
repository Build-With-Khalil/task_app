// import 'package:chat_bot/core/services/dio/dio_services.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// Future<void> main() async {
//   DioServices dioService = DioServices(BaseOptions(
//     baseUrl: 'https://jsonplaceholder.typicode.com',
//     connectTimeout: Duration(seconds: 5),
//     receiveTimeout: Duration(seconds: 5),
//   ));
//
//   try {
//     final response = await dioService.getRequest('/posts/1');
//     if (kDebugMode) {
//       print(response.data);
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }
