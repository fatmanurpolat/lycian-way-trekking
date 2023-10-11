import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:restart_project/view/maps/maps_model.dart';

class MapsViewModel {
  Future<Position?> getLocationPermission() async {
    return MapsModel().getLocationPermission();
  }

  Future<List<LatLng>> getCoordinates() async {
    return MapsModel().getCoordinates();
  }

  Future<List<Marker>> getMarkers() async {
    return MapsModel().getMarkers();
  }
}
