import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class Location {
  final LatLng startpoint; // "startPoint" -> "startpoint" olarak değiştirildi
  final LatLng endpoint; // "endPoint" -> "endpoint" olarak değiştirildi

  Location({required this.startpoint, required this.endpoint});
}

class LocationService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Location> getLocationData() async {
    final locationDoc =
        await firestore.collection('allRoutes').doc('your_document_id').get();

    if (locationDoc.exists) {
      final data = locationDoc.data() as Map<String, dynamic>;
      final startpoint = data['startpoint']
          as GeoPoint; // "startPoint" -> "startpoint" olarak değiştirildi
      final endpoint = data['endpoint']
          as GeoPoint; // "endPoint" -> "endpoint" olarak değiştirildi
      print("startpoint $startpoint");
      print("endpoint $endpoint");
      return Location(
        startpoint: LatLng(startpoint.latitude, startpoint.longitude),
        endpoint: LatLng(endpoint.latitude, endpoint.longitude),
      );
    } else {
      // Belirtilen belge yoksa veya hata oluşursa varsayılan bir değer dönebilirsiniz.
      return Location(
          startpoint: LatLng(38.14563, 39.85632),
          endpoint: LatLng(38.45632, 39.45638));
    }
  }
}
