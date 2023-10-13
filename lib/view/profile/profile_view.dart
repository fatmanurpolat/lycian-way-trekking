import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/profile/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void saveProfile() async {
    String resp = await saveData(file: _image!);
  }

  ProfileViewModel viewModel = ProfileViewModel();
  final user = FirebaseAuth.instance.currentUser;
  Uint8List? _image;
  String imageUrl = " ";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> selectImage() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      final imgBytes = await img.readAsBytes();
      setState(() {
        _image = Uint8List.fromList(imgBytes);
      });
    }
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    //   required String name,
    //required String bio,
    required Uint8List file,
  }) async {
    String resp = "Some Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage("profileImage", file);

      await _firestore.collection("userProfile").add({
        // "name": name,
        // "bio": bio,
        "imageLink": imageUrl,
      });

      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  // Future<void> uploadProfileImage(String imageUrl) async {
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

  //       // imageUrl'i güncelledikten sonra setState fonksiyonunu çağırarak arayüzü güncelleyin.
  //       setState(() {
  //         this.imageUrl = imageUrl;
  //       });

  //       print(
  //           'Profil fotoğrafı yüklendi ve Firestore\'a kaydedildi: $imageUrl');
  //     } catch (e) {
  //       print('Profil fotoğrafı yükleme hatası: $e');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage(
                  "assets/images/profile_page_photo.avif",
                ),
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6), // %60 opaklık
                  BlendMode.srcOver, // Mevcut renk üzerine uygula
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 140,
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : CircleAvatar(
                                radius: 100,
                                child: ClipOval(
                                    child: imageUrl.isNotEmpty
                                        ? Image.network(imageUrl)
                                        : Image.asset("name")),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 140,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        '${user?.displayName}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0, right: 55),
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.5, // Sayfanın yarısı kadar genişlik
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 161, 26, 17),
                        ),
                        onPressed: () async {
                          viewModel.signOut(context);
                          // saveProfile();
                        },
                        child: const Text('Çıkış Yap'),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
