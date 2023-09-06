import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restart_project/view/maps/maps_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

final mapsViewModelProvider = Provider((ref) => MapsViewModel());

final userLocationProvider = FutureProvider<Position?>((ref) async {
  final viewModel = ref.read(mapsViewModelProvider);
  return await viewModel.getLocationPermission();
});

class MapsView extends ConsumerStatefulWidget {
  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends ConsumerState<MapsView> {
  LatLng? userLocation;
  bool isLoading = true;
  final MapsViewModel viewModel = MapsViewModel();
  final MapController mapController = MapController();
  Stream<Position>? positionStream;

  //harita kontrolcüsü

  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    // İzin kontrolü yapılıyor
    checkLocationPermission();
    loadMarkersFromFirestore();
    startLocationTracking();
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );
  void startLocationTracking() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
      // Konum güncellemesi arasındaki minimum mesafe (metre cinsinden)
    );
    positionStream!.listen((Position position) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  Future<void> loadMarkersFromFirestore() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allRoutes').get();

    for (final DocumentSnapshot doc in snapshot.docs) {
      final GeoPoint? point = doc['point'] as GeoPoint?;

      if (point != null) {
        final double latitude = point.latitude;
        final double longitude = point.longitude;

        final Marker marker = Marker(
          width: 10.0,
          height: 10.0,
          point: LatLng(latitude, longitude),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.blue, // Customize the marker color here
          ),
        );

        setState(() {
          markers.add(marker);
          mapController.move(userLocation!, 15.0);
        });
      }
    }
    if (userLocation != null) {
      mapController.move(userLocation!, 15.0);
    }
  }

  // İzin kontrolü ve konum alımı
  void checkLocationPermission() async {
    final position = await viewModel.getUserLocation();

    if (position != null) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });
    } else {
      // İzin reddedildi veya verilmedi
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : userLocation != null
                  ? FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: userLocation,
                        zoom: 15.0, // Harita yakınlaştırma seviyesi
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: [
                          ...markers,
                          Marker(
                            point: userLocation!,
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 254, 2, 2),
                            ),
                          ),
                        ]),
                      ],
                    )
                  : Text('Konum bilgisi alınamadı.'),
        ),
      ),
    );
  }
}
