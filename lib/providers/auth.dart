import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_laravel_sanctum/models/user.dart';
import 'package:flutter_laravel_sanctum/services/dio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool _authenticated = false;
  User? _user;
  bool get authenticated => _authenticated;
  User? get userObject => _user;

  Future login({required Map<String, dynamic> credentials}) async {
    String deviceId = await getDeviceId();
    print('devide id:' + deviceId);
    Dio.Response response = await dio().post('auth/token',
        data: json.encode(credentials..addAll({'deviceId': deviceId})));
    String token = json.decode(response.toString())['token'];
    print(token);
    await attempt(token);
    storeToken(token);
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
      print('didnt get data from user');
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

  Future storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    return await storage.read(key: 'auth');
  }

  void deleteLocalToken() async {
    return storage.delete(key: 'auth');
  }

  void logout() async {
    await dio().delete('auth/token',
        data: {'deviceId': await getDeviceId()},
        options: Dio.Options(headers: {'auth': true}));
    deleteLocalToken();
    _authenticated = false;
    notifyListeners();
  }
}
