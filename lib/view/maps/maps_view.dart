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
  final List<Polyline> routePolylines = [];
  List<LatLng> coordinates = [];
  //harita kontrolcüsü

  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
    loadMarkersFromFirestore();
    loadDataFromFirestore();
    // startLocationTracking();
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );
  // void startLocationTracking() {
  //   positionStream = Geolocator.getPositionStream(
  //     locationSettings: locationSettings,
  //   );
  //   positionStream!.listen((Position position) {
  //     setState(() {
  //       userLocation = LatLng(position.latitude, position.longitude);
  //     });
  //   });
  // }

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
            color: Colors.blue,
          ),
        );

        setState(() {
          markers.add(marker); // Her bir nokta için bir Marker ekleyin
        });
      }
    }

    if (userLocation != null) {
      mapController.move(userLocation!, 15.0);
    }
  }

  void loadDataFromFirestore() async {
    // Firestore'dan "allRoutes" koleksiyonunu alın
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allRoutes').get();

    // Belgeden "point" alanlarını çekip coordinates listesine ekleyin
    snapshot.docs.forEach((doc) {
      GeoPoint point = doc['point'];
      coordinates.add(LatLng(point.latitude, point.longitude));
    });

    // State'i güncelleyin
    setState(() {});
  }

  Future<void> loadRoutesFromFirestore() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('allRoutes').get();

    snapshot.docs.forEach((doc) {
      GeoPoint point = doc['point'];
      coordinates.add(LatLng(point.latitude, point.longitude));
    });

    for (final DocumentSnapshot doc in snapshot.docs) {
      final String name = doc['name'] as String;
      final List<GeoPoint> points = (doc['points'] as List)
          .map((point) => GeoPoint(point['latitude'], point['longitude']))
          .toList();

      final List<LatLng> latLngPoints = points
          .map((geoPoint) => LatLng(geoPoint.latitude, geoPoint.longitude))
          .toList();

      final Polyline routePolyline = Polyline(
        points: latLngPoints,
        color: Colors.blue, // Çizgi rengi
        strokeWidth: 4.0, // Çizgi kalınlığı
        // İhtiyacınıza göre çizgiyi özelleştirin
      );

      setState(() {
        routePolylines.add(routePolyline);
        mapController.move(userLocation!, 15.0);
      });
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
              ? CircularProgressIndicator()
              : userLocation != null
                  ? FlutterMap(
                      options: MapOptions(
                        center: userLocation,
                        zoom: 15.0, // Harita yakınlaştırma seviyesi
                      ),
                      nonRotatedChildren: [
                        MarkerLayer(
                          markers: [
                            Marker(
                              rotate: true,
                              rotateOrigin: const Offset(0.1, 0.1),
                              width: 30.0,
                              height: 30.0,
                              point: userLocation!,
                              builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_on,
                                  size: 40.0,
                                  color: Color.fromARGB(255, 254, 2, 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: coordinates,
                              color: Color.fromARGB(255, 240, 139, 15),
                              strokeWidth: 2.0, // Çizgi kalınlı
                            ),
                          ],
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
