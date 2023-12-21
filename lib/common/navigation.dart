import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, String arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static backToMainPage() {
    navigatorKey.currentState?.pushReplacementNamed('/main_page');
  }
}
