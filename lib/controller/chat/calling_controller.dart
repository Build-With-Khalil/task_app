import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CallingProvider with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String botResponse = "Hello, what is your name?";
  String userResponse = "";

  /// Starts listening to user's voice
  Future<void> startListening() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );

      if (available) {
        isListening = true;
        notifyListeners();

        _speech.listen(
          onResult: (result) {
            userResponse = result.recognizedWords;
            notifyListeners();

            if (!_speech.isListening) {
              isListening = false;
              processResponse(userResponse);
            }
          },
        );
      } else {
        print("Speech recognition unavailable.");
      }
    }
  }

  /// Stops listening
  void stopListening() {
    _speech.stop();
    isListening = false;
    notifyListeners();
  }

  /// Processes the user's response
  void processResponse(String response) {
    if (botResponse == "Hello, what is your name?") {
      botResponse = "Hello $response, nice to meet you. How can I help you?";
    } else if (botResponse.contains("How can I help you?")) {
      botResponse = "Which friend? Name please.";
    } else if (botResponse.contains("Name please.")) {
      botResponse = "Calling $response.";
    }
    notifyListeners();
  }
}
