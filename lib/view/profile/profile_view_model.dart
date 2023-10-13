import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_project/view/authetication/login/login_view.dart';

class ProfileViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker imagePicker = ImagePicker();

  // Kullanıcı oturumu kapatma fonksiyonu
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }

  // Kullanıcı profilini güncelleme fonksiyonu
  Future<void> updateUserProfile(String isim, String soyisim) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('kullanicilar')
            .doc(user.uid)
            .set(
          {
            'isim': isim,
            'soyisim': soyisim,
          },
          SetOptions(merge: true),
        );
      } catch (e) {
        print('Kullanıcı profilini güncelleme hatası: $e');
      }
    }
  }

  // Kullanıcı izinlerini kontrol etme fonksiyonu
  Future<bool> requestImagePermission() async {
    try {
      final status = await Permission.camera.status;
      if (status.isGranted) {
        return true; // İzin zaten verildiyse true döndür
      } else if (status.isDenied) {
        final result = await Permission.camera.request();
        if (result.isGranted) {
          return true;
        }
      }
      return false; // İzin verilmedi veya reddedildi
    } catch (e) {
      print('Fotoğraf izni isteme hatası: $e');
      return false;
    }
  }
}
