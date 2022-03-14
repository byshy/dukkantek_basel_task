import 'package:flutter/material.dart';

extension NavigatorStateExtension on NavigatorState {
  void popUntilAndPush(String routeName, String secondaryRouteName, {Object? arguments}) {
    while (true) {
      String? currentRouteName;
      popUntil((route) {
        currentRouteName = route.settings.name;
        return true;
      });
      if (currentRouteName == routeName) {
        break;
      } else if (currentRouteName == null) {
        pushNamed(secondaryRouteName);
        break;
      } else {
        pop();
      }
    }
  }

  String getParentName({bool isParent = false}) {
    late Route _route;

    popUntil((route) {
      _route = route;

      isParent = !isParent;

      return true;
    });

    if (isParent) {
      getParentName(isParent: isParent);
    }

    return _route.settings.name ?? '';
  }
}
