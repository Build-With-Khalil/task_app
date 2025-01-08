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
      body: SafeArea(
        child: Consumer<CallingProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                /// Display Bot's Response
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mic,
                          size: 60,
                          color: Colors.teal,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Bot: ${provider.botResponse}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                /// Display User's Response
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: provider.userResponse.isEmpty
                        ? const Text(
                            "Speak into the microphone to respond.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "You: ${provider.userResponse}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),

                /// Microphone Button
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: provider.isListening
                            ? provider.stopListening
                            : provider.startListening,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: provider.isListening
                              ? Colors.redAccent
                              : Colors.teal,
                          child: Icon(
                            provider.isListening ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        provider.isListening
                            ? "Listening... Tap to stop"
                            : "Tap to start listening",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
