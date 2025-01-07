import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/auth/login_controller.dart';
import 'package:task_app/controller/chat/voice_chat_controller.dart';
import 'package:task_app/utils/route/app_pages.dart';
import 'package:task_app/utils/route/routes_name.dart';
import 'package:task_app/utils/styles/text_style.dart';

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
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoiceAssistantProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Bot',
        theme: TextStyles().textTheme,
        initialRoute: RoutesName.splash,
        routes: AppPages.getRoutes(),
      ),
    );
  }
}
