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

  @override
  void initState() {
    super.initState();
    // İzin kontrolü yapılıyor
    checkLocationPermission();
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
                      ],
                    )
                  : Text('Konum bilgisi alınamadı.'),
        ),
      ),
    );
  }
}
