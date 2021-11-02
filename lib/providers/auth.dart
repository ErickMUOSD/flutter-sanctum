import 'package:flutter/foundation.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  bool get authenticated => _authenticated;

  void login({required Map<String, dynamic> credentials}) {
    _authenticated = true;
    notifyListeners();
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
