import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/core/widgets/custom_container_list_tile.dart';
import 'package:restart_project/core/widgets/custom_elevadet_button.dart';
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainerListTile(
                  text: "Route Name:\n${routeData['name']}",
                ),
                customContainerListTile(
                  text: "Altitude Change :\n${routeData['altitude']}",
                ),
                customContainerListTile(
                  text: "Hardness :\n${routeData['difficultylevel']}",
                ),
                customContainerListTile(
                  text: "Information :\n${routeData['routeinformation']}",
                ),
                customElevatedButton(
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
                            roadName: routeData['name'],
                            startpoint: LatLng(
                                startpoint.latitude, startpoint.longitude),
                            endpoint:
                                LatLng(endpoint.latitude, endpoint.longitude),
                          ),
                        ),
                      );
                      print("endpoint latitude: ${endpoint.latitude}");
                      print("endpoint longitude: ${endpoint.longitude}");
                    },
                    buttonText: "Start Trail")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
