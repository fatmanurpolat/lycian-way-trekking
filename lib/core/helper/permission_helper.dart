import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionHelper {
  static Future<bool> checkLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      return true;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied &&
          permission != LocationPermission.deniedForever) {
        return true;
      } else {
        // İzin alınmadıysa kullanıcıyı izin vermesi için teşvik edebilirsiniz
        // ...
        return false;
      }
    } else {
      // İzin alınmadıysa kullanıcıyı izin vermesi için teşvik edebilirsiniz
      // ...
      return false;
    }
  }
}
