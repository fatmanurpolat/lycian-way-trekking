import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapsModel {
  Future<Position?> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy
              .best); // Provides more accurate results but uses more battery
    } else {
      return null; // Permission not granted or denied.
    }
  }

  Future<List<LatLng>> getCoordinates() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allRoutes').get();

    final List<LatLng> coordinates = snapshot.docs.map((doc) {
      final GeoPoint point = doc['startpoint'];
      return LatLng(point.latitude, point.longitude);
    }).toList();

    return coordinates;
  }

  Future<List<Marker>> getMarkers() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allRoutes').get();

    final List<Marker> markers = snapshot.docs.map((doc) {
      final GeoPoint point = doc['startpoint'];
      return Marker(
        width: 10.0,
        height: 10.0,
        point: LatLng(point.latitude, point.longitude),
        builder: (ctx) => const Icon(
          Icons.location_on_rounded,
          size: 20,
          color: Colors.blue,
        ),
      );
    }).toList();

    return markers;
  }
}
