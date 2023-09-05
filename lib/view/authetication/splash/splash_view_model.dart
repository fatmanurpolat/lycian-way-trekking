import 'package:flutter/material.dart';
import 'package:restart_project/view/authetication/login/login_view.dart';

class SplashViewModel {
  Future<void> initializeApp(context) async {
    await Future.delayed(Duration(seconds: 1));
    SplashViewModel().goToLoginView(context);
  }

  void goToLoginView(BuildContext context) {
    // Navigator kullanarak login sayfasına yönlendirin
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }
}
