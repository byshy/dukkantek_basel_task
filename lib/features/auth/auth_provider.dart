import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/api_repository.dart';
import '../../data/local_repository.dart';
import '../../di.dart';
import '../../environment.dart';
import '../../models/core/error_res.dart';
import '../../models/user.dart';
import '../../utils_and_services/dio_error_printer.dart';
import '../../utils_and_services/global_widgets/error_dialog.dart';
import '../../utils_and_services/routing/navigation_service.dart';
import '../../utils_and_services/routing/routes.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController loginIdentifierController =
      TextEditingController(text: kReleaseMode ? '' : sl<Environment>().testUserIdentifier);
  final TextEditingController loginPassController =
      TextEditingController(text: kReleaseMode ? '' : sl<Environment>().testUserPass);

  final FocusNode loginIdentifierFocus = FocusNode();
  final FocusNode loginPassFocus = FocusNode();

  bool isLoginLoading = false;

  String? loginIdentifierErrorString;
  String? loginPasswordErrorString;

  void loginClickHandler() {
    loginIdentifierErrorString = null;
    loginPasswordErrorString = null;
    if (loginFormKey.currentState!.validate()) {
      isLoginLoading = true;
      notifyListeners();
      runZonedGuarded(
        () {
          login();
        },
        (e, s) {
          debugPrint('loginClickHandler stacktrace:\n$s');

          if (e is DioError && e.response != null) {
            printDioError(e, 'loginClickHandler');
            ErrorResponse error = ErrorResponse.fromJson(e.response!.data);
            debugPrint('DioError in login: ${error.toString()}');
            if (error.errors == null) {
              showErrorDialog(title: 'Error', message: error.message ?? 'Unknown error');
            } else {
              if (error.errors!.containsKey('mobile')) {
                loginIdentifierErrorString = 'Mobile not found in our records';
              }

              if (error.errors!.containsKey('password')) {
                loginPasswordErrorString = 'Mobile or password are incorrect';
              }

              // loginIdentifierErrorString = error.data!.errors!['identifier'];
            }
          } else if (e is PlatformException) {
            // Do nothing
          } else {
            debugPrint('e: ${e.toString()}');
            showErrorDialog(title: 'Error', message: e.toString());
          }

          isLoginLoading = false;
          notifyListeners();
        },
      );
    }
  }

  void login() async {
    User user = await sl<ApiRepo>().login(
      data: {
        'mobile': loginIdentifierController.text,
        'password': loginPassController.text,
      },
    );

    await postAuth(value: user);
    isLoginLoading = false;
    loginIdentifierController.text = '';
    loginPassController.text = '';
    notifyListeners();
    sl<NavigationService>().navigateToAndRemove(homeScreen);
  }

  void logOut() {
    sl<LocalRepo>().removeUser();
    sl<NavigationService>().popUntilAndPush(routeName: loginScreen);
    reset();
  }

  Future<void> postAuth({required User value}) async {
    sl<LocalRepo>().setUser(value);
    refreshToken();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      postAuth(
        value: User(
          accessToken: '1234',
          userInfo: UserInfo(
            name: account?.displayName,
          ),
        ),
      );
      sl<NavigationService>().navigateToAndRemove(homeScreen);
    } catch (error) {
      print(error);
    }
  }
}
