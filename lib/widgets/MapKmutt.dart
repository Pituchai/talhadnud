import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapKmutt extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;

  const MapKmutt({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.title,
  }) : super(key: key);

  @override
  _MapKmuttState createState() => _MapKmuttState();
}

class _MapKmuttState extends State<MapKmutt> {
  late LatLng _center;
  final LatLng _destinationPoint = LatLng(13.650420, 100.495305);

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.latitude, widget.longitude);
  }

  Future<void> _launchGoogleMaps() async {
    final lat = _destinationPoint.latitude;
    final lon = _destinationPoint.longitude;
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _center,
        initialZoom: 16.0,
        onTap: (_, __) => _launchGoogleMaps(),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: _center,
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
           
          ],
        ),
      ],
    );
  }
}