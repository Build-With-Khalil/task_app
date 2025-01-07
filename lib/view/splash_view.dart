import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth/login_controller.dart';
import '../utils/route/app_navigator.dart';
import '../utils/route/routes_name.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Perform authentication check when the widget is built
    _checkAuthentication(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/chat_bot_logo.jpg',
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  Future<void> _checkAuthentication(BuildContext context) async {
    /// Wait for 3 seconds before navigating
    await Future.delayed(const Duration(seconds: 3));

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    /// Check if the user is authenticated
    await loginProvider.checkAuthStatus();

    /// After checking the status, navigate accordingly
    if (loginProvider.isAuthenticated) {
      AppNavigator.pushNamed(context, RoutesName.chat);
    } else {
      AppNavigator.pushNamed(context, RoutesName.login);
    }
  }
}
