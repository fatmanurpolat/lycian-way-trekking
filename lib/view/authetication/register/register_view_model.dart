import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restart_project/view/home/home_view.dart';

class RegisterViewModel {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController surnameTextController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    // Kullanıcı adı, şifre ve şifre onayı değerlerini alın
    String email = emailTextController.text.trim();
    String password = passwordTextController.text.trim();
    String confirmPassword = confirmTextController.text.trim();
    String name = nameTextController.text.trim();
    String surname = surnameTextController.text.trim();

    // Şifreleri kontrol edin
    if (password == confirmPassword) {
      try {
        // Firebase ile kullanıcı kaydı yapın
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Firestore'a kullanıcı bilgilerini kaydetme
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateProfile(displayName: '$name $surname');
          // await FirebaseFirestore.instance
          //     .collection('user') // Firestore koleksiyon adını buraya ekle
          //     .doc(user
          //         .uid) // Kullanıcının UID'sini kullanarak belirli bir belgeyi güncelleme
          //     .set(
          //         {
          //       'name': name,
          //       'surname': surname,
          //     },
          //         SetOptions(
          //             merge: true)); // SetOptions ile belgeyi güncellemeyi seç

          // Kullanıcı başarıyla kaydedildiyse, ana sayfaya yönlendir
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        }
      } catch (e) {
        // Kullanıcı kaydı sırasında bir hata oluşursa
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
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
      // Şifreler uyuşmuyorsa kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Şifreler uyuşmuyor!"),
      ));
    }
  }
}
