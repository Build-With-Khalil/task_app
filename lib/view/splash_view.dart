import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/route/app_navigator.dart';
import '../utils/route/routes_name.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => AppNavigator.pushNamed(
        context,
        RoutesName.login,
      ),
    );
    return const Scaffold();
  }
}
