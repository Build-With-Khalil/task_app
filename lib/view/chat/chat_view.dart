import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/auth/login_controller.dart';

import '../../controller/chat/voice_chat_controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final voiceProvider = Provider.of<VoiceAssistantProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => loginProvider.logout(context),
          icon: const Icon(
            Iconsax.arrow_left3,
          ),
        ),
        title: const Text("Voice Assistant"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display Transcription
            Text(
              voiceProvider.transcription,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Microphone Button
            GestureDetector(
              onTap: () => voiceProvider.toggleListening(),
              child: CircleAvatar(
                radius: size.width * 0.15,
                backgroundColor:
                    voiceProvider.isListening ? Colors.red : Colors.teal,
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: size.width * 0.1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Friend Name Input
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter Friend's Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => voiceProvider.friendName = value,
            ),
            const SizedBox(height: 20),

            // Call Button
            ElevatedButton(
              onPressed: () => voiceProvider.initiateCall(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Initiate Call",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
