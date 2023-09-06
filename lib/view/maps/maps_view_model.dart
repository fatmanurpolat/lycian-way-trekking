import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class MapsViewModel {
  Future<Position?> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy
              .best); //daha doğru sonuç verir ama pil kullanımını arttırır
    } else {
      return null; // İzin verilmedi veya reddedildi.
    }
  }

  Future<Position?> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return position;
    } else {
      return null; // İzin verilmedi veya reddedildi.
    }
  }
}
