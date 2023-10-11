// SplashViewModel.dart

import 'package:flutter/material.dart';
import 'package:restart_project/view/authetication/login/login_view.dart';
import 'package:restart_project/view/home/home_view.dart';

class SplashViewModel {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    // Kullanıcı oturum açık olup olmadığını kontrol etmek için bir yönetici veya servis kullanabilirsiniz.
    bool userLoggedIn = await checkIfUserLoggedIn();

    if (userLoggedIn) {
      // Kullanıcı oturum açtıysa ana sayfaya yönlendirin.
      goToHomeView(context);
    } else {
      // Kullanıcı oturum açmamışsa oturum açma ekranına yönlendirin.
      goToLoginView(context);
    }
  }

  Future<bool> checkIfUserLoggedIn() async {
    // Kullanıcının oturum açık olup olmadığını kontrol etmek için uygun bir yöntemi kullanın.
    // Örneğin, bir oturum yöneticisi kullanabilirsiniz.
    // Bu işlem asenkron olabilir, bu nedenle "Future<bool>" döndürdük.

    // Örnek: Bir kullanıcının oturum açık olup olmadığını kontrol eden bir işlevi çağırın.
    // Bu işlemi gerçekleştirirken kullanıcı oturum açık ise true, aksi takdirde false döndürmelisiniz.
    return false; // Örnek: Kullanıcı oturum açmamış.
  }

  void goToLoginView(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }

  void goToHomeView(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }
}
