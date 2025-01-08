import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/auth/login_controller.dart';

import '../../controller/chat/calling_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/route/routes_name.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        /// Back button to log out and navigate to the login screen
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
        title: const Text("Calling Screen"),
      ),
      body: SafeArea(
        child: Consumer<CallingProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                /// Bot's Response Section
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
                        /// Bot icon
                        Image.asset(
                          "assets/images/robo_icon.png",
                          height: 100,
                        ),
                        const SizedBox(height: 20),

                        /// Display bot's response
                        Text(
                          provider.botResponse,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: AppColors.secondaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                /// User's Response Section
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,

                    /// Show placeholder text or user's response
                    child: provider.userResponse.isEmpty
                        ? Text(
                            "Speak into the microphone to respond.",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: AppColors.grey),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "You: ${provider.userResponse}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(color: AppColors.secondaryColor),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),

                /// Microphone Interaction Section
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Microphone button to toggle listening
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

                      /// Instruction text below the button
                      Text(
                        provider.isListening
                            ? "Listening... Tap to stop"
                            : "Tap to start listening",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: AppColors.grey),
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
