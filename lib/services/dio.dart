import 'package:dio/dio.dart';

Dio dio() {
  String _virtualDevice = '10.0.2.2:8000';
  String _realDevice = '192.168.0.30:8000';
  var dio = Dio(BaseOptions(
      baseUrl: 'http://$_virtualDevice/api/',
      responseType: ResponseType.plain,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json'
      }));
  return dio;
}
