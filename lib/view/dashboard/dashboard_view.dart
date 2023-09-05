import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/core/widgets/custom_card.dart';
import 'package:restart_project/view/detail/detail_view.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 241, 241),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customCard(
                  backgrounColor: CustomColors.ORANGE_BUTTON,
                  title: "ffffff",
                  value: "5.2",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsView('Atılan Adım Sayısı')));
                  },
                ),
                customCard(
                  backgrounColor: CustomColors.ORANGE_BUTTON,
                  title: "ffffff",
                  value: "5.2",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsView('Atılan Adım Sayısı')));
                  },
                ),
                customCard(
                  backgrounColor: CustomColors.ORANGE_BUTTON,
                  title: "ffffff",
                  value: "5.2",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsView('Atılan Adım Sayısı')));
                  },
                ),
                customCard(
                  backgrounColor: CustomColors.ORANGE_BUTTON,
                  title: "ffffff",
                  value: "5.2",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsView('Atılan Adım Sayısı')));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
