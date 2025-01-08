import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  /// Set user data (only ID for now)
  void setUserId(String userId) {
    _user = User(id: userId);
    notifyListeners();
  }

  /// Save user ID to local storage
  Future<void> saveUserIdToPreferences(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  /// Load user ID from local storage
  Future<void> loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');

    if (userId != null) {
      _user = User(id: userId.toString());
      notifyListeners();
    }
  }
}
