import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/auth/login_controller.dart';
import 'package:task_app/utils/route/app_pages.dart';
import 'package:task_app/utils/route/routes_name.dart';

import 'utils/styles/text_style.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider()..checkAuthStatus(),
        ),
      ],
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return MaterialApp(
            title: "Chat Bot",
            theme: TextStyles().textTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: loginProvider.isAuthenticated
                ? RoutesName.chat
                : RoutesName.splash,
            routes: AppPages.getRoutes(),
          );
        },
      ),
    );
  }
}
