import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:carspace/widgets/PopupMap.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingMap extends StatelessWidget {
  const ParkingMap({super.key});

  static  List<Marker> _markers = [
    const LatLng(45.75994,21.22956),
    const LatLng(45.75553,21.22194),
    const LatLng(45.75627,21.23615),
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
      options:  MapOptions(
        initialZoom: 14.6,
        initialCenter: LatLng(45.75372,21.22571),
        onTap: (tapPos,latlng){
          _markers.add(
            Marker(point: latlng, child: Icon(Icons.location_on, size: 40))
          );
        },
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