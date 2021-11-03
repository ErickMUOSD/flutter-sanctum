import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_laravel_sanctum/models/user.dart';
import 'package:flutter_laravel_sanctum/services/dio.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  User? _user;
  bool get authenticated => _authenticated;
  User? get userObject => _user;

  Future login({required Map<String, dynamic> credentials}) async {
    Dio.Response response =
        await dio().post('auth/token', data: json.encode(credentials));
    String token = json.decode(response.toString())['token'];
    await attempt(token);
  }

  Future attempt(String token) async {
    //take token, make request to endpoint
    try {
      Dio.Response response = await dio().get('auth/user',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      _user = User.fromJson(jsonDecode(response.toString()));
      _authenticated = true;
    } catch (e) {
      _authenticated = false;
    }
    notifyListeners();
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
