import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/utils/route/routes_name.dart';

import '../../controller/auth/login_controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            /// Log out the user
            Provider.of<LoginProvider>(context, listen: false).logout();
            Navigator.pushReplacementNamed(
              context,
              RoutesName.login,
            );
          },
        ),
        title: const Text('Chat'),
      ),
    );
  }
}
