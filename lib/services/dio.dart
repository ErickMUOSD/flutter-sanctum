import 'package:dio/dio.dart';
import 'package:flutter_laravel_sanctum/providers/auth.dart';

Dio dio() {
  String _virtualDevice = '10.0.2.2:8000';
  String _realDevice = '192.168.0.30:8000';
  var dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      }));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      requestInterceptor(options);
      return handler.next(options);
    },
  ));

  return dio;
}

void requestInterceptor(RequestOptions options) async {
  if (options.headers.containsKey('auth')) {
    var token = await Auth().getToken();
    print(token);
    options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}
