import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_project/view/authetication/register/register_view.dart';
import 'package:restart_project/view/home/home_view.dart';

class LoginViewModel {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  Future<void> checkCurrentUser(context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => const HomeView()),
      );
    }
  }

  Future<void> login(BuildContext context) async {
    String email = emailTextController.text.trim();
    String password = passwordTextController.text.trim();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Giriş başarılı, ana sayfaya yönlendirin
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const HomeView()),
        );
      } else {
        // Kullanıcı bilgileri hatalı
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: const Text('Kullanıcı adı veya şifre hatalı.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Kapat'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Giriş sırasında bir hata oluştu
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: Text('Giriş sırasında bir hata oluştu: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat'),
              ),
            ],
          );
        },
      );
    }
  }

  goToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterView(),
      ),
    );
  }
}
