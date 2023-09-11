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
        MaterialPageRoute(builder: (ctx) => HomeView()),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => HomeView()),
        );
      } else {
        // Kullanıcı bilgileri hatalı
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Kullanıcı adı veya şifre hatalı.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Kapat'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Giriş sırasında bir hata oluştu
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Giriş sırasında bir hata oluştu: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Kapat'),
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
        builder: (context) => RegisterView(),
      ),
    );
  }
}
