import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/detail_maps/detail_map_view.dart';

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
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 138, 133, 133),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/rota_detail_photo.jpg"),
          //     fit: BoxFit.cover, // Görüntünün tam sayfa boyutunu kaplaması için
          //     colorFilter: ColorFilter.mode(
          //       Colors.black.withOpacity(0.4), // %60 opaklık
          //       BlendMode.srcOver, // Mevcut renk üzerine uygula
          //     ),
          //   ),
          // ),
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
                        '\t \t \t \t Name: \n ${routeData['name']}',
                        style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 4,
                          fontFamily: 'YoungSerif',
                          fontWeight: FontWeight.w500,
                        ),
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
                        '\t \t  Altitude: \n ${routeData['altitude']}',
                        style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 4,
                          fontFamily: 'YoungSerif',
                          fontWeight: FontWeight.w500,
                        ), // Yazı rengi
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
                        '\t  Difficulty Level: \n \t\t\t\t\t \t\t${routeData['difficultylevel']}',
                        style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 4,
                          fontFamily: 'YoungSerif',
                          fontWeight: FontWeight.w500,
                        ),
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
                        '\t\t\t\t\t\t\t        Route Information: \n ${routeData['routeinformation']}',
                        style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 4,
                          fontFamily: 'YoungSerif',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final GeoPoint startpoint = routeData['startpoint'];
                    final GeoPoint endpoint = routeData['endpoint'];
                    // print("startpoint latitude: ${startpoint.latitude}");
                    // print("startpoint longitude: ${startpoint.longitude}");
                    print("endpoint latitude: ${endpoint.latitude}");
                    print("endpoint longitude: ${endpoint.longitude}");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailMapView(
                          startpoint:
                              LatLng(startpoint.latitude, startpoint.longitude),
                          endpoint:
                              LatLng(endpoint.latitude, endpoint.longitude),
                        ),
                      ),
                    );
                    print("endpoint latitude: ${endpoint.latitude}");
                    print("endpoint longitude: ${endpoint.longitude}");
                  },
                  child: Text("Maceraya Başla"),
                  // ...
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
