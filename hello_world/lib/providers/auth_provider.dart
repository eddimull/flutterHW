import 'package:flutter/material.dart';
import 'package:hello_world/services/api.dart';

class AuthProvider extends ChangeNotifier {
  ApiService apiService = ApiService('');
  bool _isLoggedIn = false;
  late String _token;

  String get token => _token;
  AuthProvider();

  bool get isAuthenticated => _isLoggedIn;

  Future<void> register(String name, String email, String password, String passwordConfirm, String deviceName) async {
      _token = await apiService.register(name, email, password, passwordConfirm, deviceName);
      _isLoggedIn = true;
      notifyListeners(); 
  }

  Future<void> login(String email, String password, String deviceName) async {
      _token = await apiService.login(email, password, deviceName);
      _isLoggedIn = true;
      notifyListeners(); 
  }

    Future<void> logout() async {
      _token = '';
      _isLoggedIn = false;
      notifyListeners(); 
  }
}