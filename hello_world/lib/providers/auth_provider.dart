import 'package:flutter/material.dart';
import 'package:hello_world/services/api.dart';

class AuthProvider extends ChangeNotifier {
  ApiService apiService = ApiService();
  bool _isLoggedIn = false;

  AuthProvider();

  bool get isAuthenticated => _isLoggedIn;

  Future<String> register(String name, String email, String password, String passwordConfirm, String deviceName) async {
      String token = await apiService.register(name, email, password, passwordConfirm, deviceName);
      _isLoggedIn = true;
      notifyListeners(); 

      return token;

  }

  Future<String> login(String email, String password, String deviceName) async {
      String token = await apiService.login(email, password, deviceName);
      _isLoggedIn = true;
      notifyListeners(); 

      return token;

  }
}