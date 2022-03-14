import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api_repository.dart';
import 'data/local_repository.dart';
import 'environment.dart';
import 'features/auth/auth_provider.dart';
import 'features/home/home_provider.dart';
import 'models/user.dart';
import 'utils_and_services/routing/navigation_service.dart';

/// sl: service locator
final sl = GetIt.instance;

const Env runningEnvironment = Env.prod;

Future<void> init() async {
  sl.registerLazySingleton<Environment>(() => Environment(runningEnvironment));

  sl.registerLazySingleton<LocalRepo>(
    () => LocalRepo(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<ApiRepo>(
    () => ApiRepo(
      client: sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  Dio client = Dio(
    BaseOptions(
      baseUrl: sl<Environment>().baseURL,
      contentType: 'application/json',
    ),
  );

  sl.registerLazySingleton<Dio>(() => client);

  sl.registerLazySingleton(() => AuthProvider());
  sl.registerLazySingleton(() => HomeProvider());

  sl.registerLazySingleton(() => NavigationService());

  refreshToken();
}

void reset() {
  sl.resetLazySingleton<AuthProvider>();
  sl.resetLazySingleton<HomeProvider>();
}

void refreshToken() {
  final User? user = sl<LocalRepo>().getUser();
  debugPrint('token: ${user?.accessToken}');
  if (user != null) {
    sl<Dio>().options.headers.addAll({'access_token': user.accessToken});
  }
}
