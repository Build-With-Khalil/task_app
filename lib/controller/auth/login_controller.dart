import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/dio/dio_services.dart';

class LoginProvider with ChangeNotifier {
  /// Removed the formKey here
  bool isObscure = true;

  /// Controllers for login inputs
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Tokens
  String? _accessToken;
  String? _refreshToken;
  bool _isAuthenticated = false;

  /// Getter for access token
  bool get isAuthenticated => _isAuthenticated;

  final DioService dioService = DioService();

  /// Toggle password visibility
  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  /// Login function
  Future<void> login() async {
    const String loginUrl =
        "https://stagingapi.calling-all-kids.com/api/user/auth/login";

    try {
      /// API call for login
      final response = await dioService.postRequest(loginUrl, {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      if (response.statusCode == 200 && response.data['error'] == false) {
        final data = response.data['data'];

        /// Extract tokens
        _accessToken = data['accessToken'];
        _refreshToken = data['refreshToken'];

        /// Save tokens to SharedPreferences
        final preferences = await SharedPreferences.getInstance();
        await preferences.setString('accessToken', _accessToken!);
        await preferences.setString('refreshToken', _refreshToken!);

        _isAuthenticated = true;
        notifyListeners();
      } else {
        throw Exception(response.data['message'] ?? "Login failed");
      }
    } catch (e) {
      throw Exception("Login request failed: $e");
    }
  }

  /// Check for authentication status
  Future<void> checkAuthStatus() async {
    final preferences = await SharedPreferences.getInstance();
    _accessToken = preferences.getString('accessToken');
    _refreshToken = preferences.getString('refreshToken');

    _isAuthenticated = _accessToken != null && _refreshToken != null;
    notifyListeners();
  }

  /// Logout function
  Future<void> logout() async {
    // Clear tokens and local data
    _accessToken = null;
    _refreshToken = null;
    _isAuthenticated = false;

    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('accessToken');
    await preferences.remove('refreshToken');

    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
