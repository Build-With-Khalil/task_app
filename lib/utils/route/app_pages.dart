import 'package:flutter/material.dart';
import 'package:task_app/utils/route/routes_name.dart';

import '../../view/chat/chat_view.dart';
import '../../view/login/login_view.dart';
import '../../view/splash_view.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutesName.splash: (context) => const SplashView(),
      RoutesName.login: (context) => const LoginView(),
      RoutesName.chat: (context) => const ChatView(),
    };
  }
}
