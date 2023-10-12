import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:restart_project/core/utils/app_config.dart';

class DetailMapView extends StatefulWidget {
  final LatLng startpoint;
  final LatLng endpoint;
  final String roadName;

  DetailMapView(
      {required this.startpoint,
      required this.endpoint,
      required this.roadName});

  @override
  _DetailMapViewState createState() => _DetailMapViewState();
}

class _DetailMapViewState extends State<DetailMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of ${widget.roadName}'),
        backgroundColor: CustomColors.DARK_GREEN,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: widget.startpoint, // Başlangıç noktasını merkeze al
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [widget.startpoint, widget.endpoint],
                color: const Color.fromARGB(255, 228, 5, 5),
                strokeWidth: 4.0,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: widget.startpoint,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 64, 156, 231),
                  size: 25,
                ),
              ),
              Marker(
                  point: widget.endpoint,
                  builder: (ctx) => const Icon(
                        Icons.location_on_outlined,
                        color: Color.fromARGB(255, 29, 80, 31),
                        size: 25,
                      ))
            ],
          )
        ],
      ),
    );
  }
}
