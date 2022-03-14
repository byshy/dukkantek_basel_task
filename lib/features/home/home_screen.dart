import 'package:dukkantek_basel_task/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../di.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => sl<AuthProvider>().logOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(child: Text("I finished the task!")),
    );
  }
}
