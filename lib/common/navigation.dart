import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {

  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}