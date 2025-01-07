import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceAssistantProvider extends ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = "Tap the microphone and start speaking...";
  String _friendName = "";

  bool get isListening => _isListening;
  String get transcription => _transcription;
  String get friendName => _friendName;

  set friendName(String name) {
    _friendName = name;
    notifyListeners();
  }

  /// Handles the speech-to-text functionality
  Future<void> toggleListening() async {
    if (!_isListening) {
      if (await Permission.microphone.request().isGranted) {
        final isAvailable = await _speech.initialize(
          onStatus: (status) => debugPrint("Speech Status: $status"),
          onError: (error) => debugPrint("Speech Error: $error"),
        );
        if (isAvailable) {
          _isListening = true;
          _speech.listen(
            onResult: (result) {
              _transcription = result.recognizedWords;
              notifyListeners();
            },
          );
        }
      } else {
        _transcription = "Microphone permission is required!";
        notifyListeners();
      }
    } else {
      _isListening = false;
      _speech.stop();
      notifyListeners();
    }
  }

  /// Displays "Calling [friend-name]" when the call is initiated
  void initiateCall() {
    if (_friendName.isNotEmpty) {
      _transcription = "Calling $_friendName...";
    } else {
      _transcription = "Please enter a friend's name!";
    }
    notifyListeners();
  }
}
