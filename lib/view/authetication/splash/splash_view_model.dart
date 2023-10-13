// SplashViewModel.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_project/view/authetication/login/login_view.dart';
import 'package:restart_project/view/home/home_view.dart';

class SplashViewModel {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
  }
}
