import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/profile/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileViewModel viewModel = ProfileViewModel();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(user?.photoURL ?? ''),
              backgroundColor: CustomColors.DARK_GREEN,
            ),
            const SizedBox(height: 20),
            if (user != null)
              Container(
                decoration: BoxDecoration(
                    color: CustomColors.LIGHT_GREEN,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '  Hoş Geldin! \n${user.email}',

                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    //user?.displayName ?? '',
                  ),
                ),
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.GEOMARKET_DARK_BLUE),
              onPressed: () async {
                viewModel.signOut(context);
                // ignore: use_build_context_synchronously
              },
              child: const Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
