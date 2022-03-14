import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../../features/auth/auth_provider.dart';
import '../../features/auth/login_screen.dart';
import '../../features/home/home_provider.dart';
import '../../features/home/home_screen.dart';
import 'routes.dart';

class DukkantekRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: loginScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const LoginScreen(),
            value: sl<AuthProvider>(),
          ),
        );
      case homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: homeScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const HomeScreen(),
            value: sl<HomeProvider>(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
