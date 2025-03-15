import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:carspace/widgets/PopupMap.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingMap extends StatelessWidget {
  const ParkingMap({super.key});

  static final List<Marker> _markers = [
    const LatLng(44.421, 10.404),
    const LatLng(45.683, 10.839),
    const LatLng(45.246, 5.783),
  ]
      .map(
        (markerPosition) => Marker(
              point: markerPosition,
              width: 40,
              height: 40,
              child: Icon(Icons.location_on, size: 40)
            ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialZoom: 5.0,
        initialCenter: LatLng(44.421, 10.404),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: "com.itfest25.carspace",
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: _markers,
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) =>
                  PopupMap(marker),
            ),
          ),
        ),
        RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }
}