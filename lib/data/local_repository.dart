import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LocalRepo {
  final SharedPreferences sharedPreferences;

  LocalRepo({required this.sharedPreferences});

  static const _user = 'user';

  Future<void> setUser(User user) {
    String userJson = jsonEncode(user);
    return sharedPreferences.setString(_user, userJson);
  }

  User? getUser() {
    String? user = sharedPreferences.getString(_user);
    if (user != null) {
      var map = jsonDecode(user);
      return User.fromJson(map);
    }
    return null;
  }

  void removeUser() {
    sharedPreferences.remove(_user);
  }
}
