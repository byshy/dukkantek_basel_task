import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils_and_services/global_widgets/custom_raised_button.dart';
import '../../utils_and_services/global_widgets/loading_indicator.dart';
import 'auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;

  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (_, instance, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Form(
                key: instance.loginFormKey,
                autovalidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Placeholder(
                      fallbackHeight: 80,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: instance.loginIdentifierController,
                      focusNode: instance.loginIdentifierFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(instance.loginPassFocus);
                      },
                      validator: (string) {
                        if (instance.loginIdentifierErrorString != null) {
                          return instance.loginIdentifierErrorString;
                        }

                        if (string!.isEmpty) {
                          return 'Required field';
                        }

                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(labelText: 'Mobile'),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: instance.loginPassController,
                      focusNode: instance.loginPassFocus,
                      textInputAction: TextInputAction.done,
                      obscureText: obscurePassword,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      validator: (string) {
                        if (instance.loginPasswordErrorString != null) {
                          return instance.loginPasswordErrorString;
                        }

                        if (string?.isEmpty ?? true) {
                          return 'Required field';
                        } else if ((string?.length ?? 0) < 5) {
                          return 'Short password';
                        }

                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility_off : Icons.visibility_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              CustomRaisedButton(
                onTap: instance.isLoginLoading
                    ? null
                    : () {
                        instance.loginClickHandler();
                        setState(() {
                          autoValidate = true;
                          obscurePassword = true;
                        });
                      },
                child: instance.isLoginLoading
                    ? const LoadingIndicator()
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
