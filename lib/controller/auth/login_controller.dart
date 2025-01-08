import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/dio/dio_services.dart';
import '../../utils/route/app_navigator.dart';
import '../../utils/route/routes_name.dart';
import '../chat/chat_controller.dart';

class LoginProvider with ChangeNotifier {
  /// Variables for password visibility, login status, and loading state
  bool isObscure = true;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  /// Controllers for login inputs
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Tokens
  String? _accessToken;
  String? _refreshToken;

  /// Id
  int? _userId;

  /// Getter for login status and loading state
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  /// Dio Object
  final DioService dioService = DioService();

  /// Toggle password visibility
  void toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  /// Toggle loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Login function
  Future<void> login(BuildContext context) async {
    const String loginUrl = "/user/auth/login";

    setLoading(true); // Start loading

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

        /// Extract Id
        _userId = data['user']['id'];

        /// Save tokens to SharedPreferences
        final preferences = await SharedPreferences.getInstance();
        await preferences.setString('accessToken', _accessToken!);
        await preferences.setString('refreshToken', _refreshToken!);
        await preferences.setInt('id', _userId!);

        _isAuthenticated = true;
        notifyListeners();

        /// Navigate to ChatView
        AppNavigator.pushNamed(context, RoutesName.chat);

        /// Clear input fields
        emailController.clear();
        passwordController.clear();

        /// Show success message
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        /// Show error message
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      /// Show error message
      Fluttertoast.showToast(
        msg: "invalid email or password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setLoading(false); // Stop loading
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

  void onLoginSuccess(BuildContext context, int? userId) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserId(userId.toString());
    userProvider.saveUserIdToPreferences(userId.toString());
  }

  /// Logout function
  Future<void> logout(BuildContext context) async {
    setLoading(false); // Start loading
    try {
      /// Clear tokens and local data
      _accessToken = null;
      _refreshToken = null;
      _userId = null;
      _isAuthenticated = false;

      final preferences = await SharedPreferences.getInstance();
      await preferences.remove('accessToken');
      await preferences.remove('refreshToken');
      preferences.remove('id');
      notifyListeners();

      /// Navigate to LoginView
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => false);
    } finally {
      setLoading(false); // Stop loading
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
