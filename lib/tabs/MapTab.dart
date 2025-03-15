import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/PopupMenu.dart';
class MapTab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MapTabState();

}

class _MapTabState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:<Widget>[PopupMenu()]),
      body:FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.509364, -0.128928), // Center the map over London
          initialZoom: 9.2,
        ),
        children: [
          TileLayer( // Bring your own tiles
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
            userAgentPackageName: 'com.itfest25.carspace', // Add your app identifier
            // And many more recommended properties!
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
      )
    );
  }
}