import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/arguments/Arguments.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> pushTo(String routeName, {Arguments arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceTo(String routeName, {Arguments arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    return navigatorKey.currentState.pop();
  }
}
