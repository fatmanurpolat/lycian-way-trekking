import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';

class RouteDetailsView extends StatelessWidget {
  final Map<String, dynamic> routeData;

  RouteDetailsView({required this.routeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.DARK_GREEN,
        title: Text(routeData['name']),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/rota_detail_photo.jpg"),
            fit: BoxFit.cover, // Görüntünün tam sayfa boyutunu kaplaması için
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), // %60 opaklık
              BlendMode.srcOver, // Mevcut renk üzerine uygula
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.7), // Kartın arka plan rengi ve opaklık
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Name: ${routeData['name']}',
                      style: TextStyle(
                          color: CustomColors.DARK_GREEN), // Yazı rengi
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.7), // Kartın arka plan rengi ve opaklık
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Altitude: ${routeData['altitude']}',
                      style: TextStyle(
                          color: CustomColors.DARK_GREEN), // Yazı rengi
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.7), // Kartın arka plan rengi ve opaklık
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Time: ${routeData['time']}',
                      style: TextStyle(
                          color: CustomColors.DARK_GREEN), // Yazı rengi
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.7), // Kartın arka plan rengi ve opaklık
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Distance: ${routeData['distance']}',
                      style: TextStyle(
                          color: CustomColors.DARK_GREEN), // Yazı rengi
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
