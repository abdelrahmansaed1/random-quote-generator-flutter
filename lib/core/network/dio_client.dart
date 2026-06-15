import 'package:dio/dio.dart';
import 'package:qoute_app/core/network/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: ApiConstants.connectTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    // Logs requests/responses while developing.
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: true, error: true),
    );
  }

  Future<Response> get(String path) async {
    return dio.get(path);
  }
}
