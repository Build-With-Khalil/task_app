import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/auth/login_controller.dart';

import '../../controller/chat/calling_controller.dart';
import '../../controller/chat/chat_controller.dart';
import '../../utils/route/routes_name.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    if (userProvider.user == null) {
      // Load user ID from local storage
      userProvider.loadUserFromPreferences();
    }

    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            loginProvider.setLoading(false);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.login,
              (route) => false,
            );
          },
        ),
        title: Text(user!.id.toString()),
      ),
      body: Consumer<CallingProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bot: ${provider.botResponse}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              if (provider.userResponse.isNotEmpty)
                Text(
                  "You: ${provider.userResponse}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: provider.isListening
                    ? provider.stopListening
                    : provider.startListening,
                icon: Icon(provider.isListening ? Icons.mic_off : Icons.mic),
                label: Text(provider.isListening
                    ? "Stop Listening"
                    : "Start Listening"),
              ),
            ],
          );
        },
      ),
    );
  }
}
