import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restart_project/view/home/home_view.dart';

class RegisterViewModel {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmTextController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    // Kullanıcı adı, şifre ve şifre onayı değerlerini alın
    String username = userNameTextController.text.trim();
    String password = passwordTextController.text.trim();
    String confirmPassword = confirmTextController.text.trim();

    // Şifreleri kontrol edin
    if (password == confirmPassword) {
      try {
        // Firebase ile kullanıcı kaydı yapın
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );

        // Kullanıcı başarıyla kaydedildiyse, ana sayfaya yönlendirin
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } catch (e) {
        // Kullanıcı kaydı sırasında bir hata oluşursa, hatayı gösterin
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hata'),
              content: Text('Kullanıcı kaydı başarısız oldu: $e'),
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
    } else {
      // Şifreler uyuşmuyorsa kullanıcıya bilgi verin
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Şifreler uyuşmuyor!"),
      ));
    }
  }
}
