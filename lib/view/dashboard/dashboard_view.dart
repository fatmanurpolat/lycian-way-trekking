import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/dashboard/dashboard_selection_route.dart';

class DashboardMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/detail_photo.webp"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Yarı opaklık için renk ayarı
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DashboardSelectionView(),
              ));
            },
            child: Text('Rota Seç'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 40, 112, 44)!, // Orman yeşili renk
              ),
            ),
          ),
        ),
      ),
    );
  }
}
