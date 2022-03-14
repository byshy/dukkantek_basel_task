import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../di.dart';
import '../routing/navigation_service.dart';

void showErrorDialog({
  required String title,
  required String message,
  VoidCallback? onOkTap,
  RouteSettings? routeSettings,
}) {
  showDialog(
    context: sl<NavigationService>().getContext(),
    routeSettings: routeSettings,
    builder: (_) {
      return Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: onOkTap ?? () => sl<NavigationService>().navigateToPrevious(),
                ),
              ],
            )
          : AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: onOkTap ?? () => sl<NavigationService>().navigateToPrevious(),
                ),
              ],
            );
    },
  );
}
