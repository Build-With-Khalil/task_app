import 'dart:async';

import 'package:flutter/material.dart';

/// -- App Navigators --
class AppNavigator {
  /// - Pop
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  /// - push Named
  static pushNamed(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
  }

  /// - push Named Replace
  static pushNamedReplace(BuildContext context, String page) {
    Navigator.pushReplacementNamed(context, page);
  }

  /// - Remove All
  static removeAll(BuildContext context, String page) {
    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  /// - Replace Page Time
  static replacePageTime(BuildContext context, String page, int? seconds) {
    Timer(
      Duration(seconds: seconds ?? 2),
      () {
        pushNamedReplace(context, page);
      },
    );
  }
}
