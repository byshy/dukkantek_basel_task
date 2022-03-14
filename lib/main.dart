import 'package:dukkantek_basel_task/data/local_repository.dart';
import 'package:dukkantek_basel_task/utils_and_services/routing/routes.dart';
import 'package:flutter/material.dart';

import 'di.dart';
import 'utils_and_services/routing/navigation_service.dart';
import 'utils_and_services/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const DukkantedApp());
}

class DukkantedApp extends StatefulWidget {
  const DukkantedApp({Key? key}) : super(key: key);

  @override
  State<DukkantedApp> createState() => _DukkantedAppState();
}

class _DukkantedAppState extends State<DukkantedApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukkanted',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: sl<NavigationService>().navigatorKey,
      initialRoute: getHome(),
      onGenerateRoute: DukkantekRouter.generateRoute,
    );
  }

  String getHome() {
    if (sl<LocalRepo>().getUser() == null) {
      return loginScreen;
    }

    return homeScreen;
  }
}