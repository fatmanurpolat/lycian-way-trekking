import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:restart_project/view/maps/maps_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

final mapsViewModelProvider = Provider((ref) => MapsViewModel());

final userLocationProvider = FutureProvider<Position?>((ref) async {
  final viewModel = ref.read(mapsViewModelProvider);
  return await viewModel.getLocationPermission();
});

final coordinatesProvider = FutureProvider<List<LatLng>>((ref) async {
  final viewModel = ref.read(mapsViewModelProvider);
  return await viewModel.getCoordinates();
});

final markersProvider = FutureProvider<List<Marker>>((ref) async {
  final viewModel = ref.read(mapsViewModelProvider);
  return await viewModel.getMarkers();
});

class MapsView extends ConsumerWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocation = ref.watch(userLocationProvider);
    final coordinates = ref.watch(coordinatesProvider);
    final markers = ref.watch(markersProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: userLocation.when(
            data: (position) {
              return coordinates.when(
                data: (coords) {
                  return markers.when(
                    data: (mapMarkers) {
                      return FlutterMap(
                        options: MapOptions(
                          center:
                              LatLng(position!.latitude, position.longitude),
                          zoom: 15.0,
                        ),
                        nonRotatedChildren: [
                          RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () => launchUrl(
                                  Uri.parse(
                                      'https://openstreetmap.org/copyright'),
                                ),
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
                                points: coords,
                                color: const Color.fromARGB(255, 59, 0, 254),
                                strokeWidth: 4.0,
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: [
                              ...mapMarkers,
                              Marker(
                                point: LatLng(
                                    position.latitude, position.longitude),
                                builder: (ctx) => const Icon(
                                  Icons.my_location_rounded,
                                  size: 25,
                                  color: Color.fromARGB(255, 254, 2, 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, _) => Text('Error: $error'),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('Error: $error'),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
