import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_laravel_sanctum/models/user.dart';
import 'package:flutter_laravel_sanctum/services/dio.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  User? _user;
  bool get authenticated => _authenticated;
  User? get userObject => _user;

  Future login({required Map<String, dynamic> credentials}) async {
    String deviceId = await getDeviceId();
    print(deviceId);
    Dio.Response response = await dio().post('auth/token',
        data: json.encode(credentials..addAll({'deviceId': deviceId})));
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

  Future getDeviceId() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      return deviceId;
    } catch (e) {
      _authenticated = false;
    }
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
