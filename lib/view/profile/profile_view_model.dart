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

  // // Profil fotoğrafını yükleme fonksiyonu
  // Future<void> uploadProfileImage(Function(String) setImageUrl) async {
  //   final user = _auth.currentUser;

  //   if (user != null) {
  //     try {
  //       final image = await ImagePicker().pickImage(
  //         source: ImageSource.gallery,
  //         maxWidth: 512,
  //         maxHeight: 512,
  //         imageQuality: 75,
  //       );
  //       Reference ref =
  //           FirebaseStorage.instance.ref().child("profile_resim.jpg");

  //       await ref.putFile(File(image!.path));
  //       final imageUrl = await ref.getDownloadURL();

  //       // Firestore'da kullanıcı belgesini güncelleme
  //       await _firestore.collection('users').doc(user.uid).set(
  //         {'profile_image_url': imageUrl},
  //         SetOptions(merge: true),
  //       );

  //       // imageUrl'i güncelledikten sonra setImageUrl fonksiyonunu çağırarak arayüzü güncelleyin.
  //       setImageUrl(imageUrl);

  //       print(
  //           'Profil fotoğrafı yüklendi ve Firestore\'a kaydedildi: $imageUrl');
  //     } catch (e) {
  //       print('Profil fotoğrafı yükleme hatası: $e');
  //     }
  //   }
  // }

  // Kullanıcı oturumu kapatma fonksiyonu
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginView()));
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

// class ProfileView extends StatefulWidget {
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   ProfileViewModel viewModel = ProfileViewModel();
//   final user = FirebaseAuth.instance.currentUser;
//   Uint8List? _image;
//   String imageUrl =
//       "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"; // Varsayılan profil fotoğrafı URL'si

//   // Diğer kodlar...

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profil'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               viewModel.signOut(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 16),
//             _image != null
//                 ? CircleAvatar(
//                     radius: 64,
//                     backgroundImage: MemoryImage(_image!),
//                   )
//                 : CircleAvatar(
//                     radius: 64,
//                     child: ClipOval(child: Image.asset('')),
//                   ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 viewModel.uploadProfileImage((url) {
//                   setState(() {
//                     imageUrl = url;
//                   });
//                 });
//               },
//               child: Text('Profil Fotoğrafını Yükle'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 viewModel.updateUserProfile('Yeni İsim', 'Yeni Soyisim');
//               },
//               child: Text('Profil Bilgilerini Güncelle'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
