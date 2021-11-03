import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_laravel_sanctum/services/dio.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  bool get authenticated => _authenticated;

  Future login({required Map<String, dynamic> credentials}) async {
    _authenticated = true;
    Dio.Response response =
        await dio().post('auth/token', data: json.encode(credentials));
    String token = json.decode(response.toString())['token'];
    print(token);
    notifyListeners();
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
