import 'package:dukkantek_basel_task/utils_and_services/routing/nav_extension.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndRemove(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  void navigateToAndPopUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(
      ModalRoute.withName(routeName),
    );
  }

  void popUntilAndPush({required String routeName, String? secondaryRouteName, Object? arguments}) {
    navigatorKey.currentState!.popUntilAndPush(
      routeName,
      secondaryRouteName ?? routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndReplace(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  void navigateToPrevious() {
    return navigatorKey.currentState!.pop();
  }

  BuildContext getContext() {
    return navigatorKey.currentState!.overlay!.context;
  }

  String getParentName({bool isParent = false}) {
    return navigatorKey.currentState!.getParentName(isParent: isParent);
  }
}