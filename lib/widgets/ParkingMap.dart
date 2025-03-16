import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:carspace/widgets/PopupMap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';


class ParkingMap extends StatefulWidget {
  @override
  _ParkingMapState createState() => _ParkingMapState();
}

class _ParkingMapState extends State<ParkingMap>{
  LatLng? _currentPosition;
  final MapController _mapController = MapController();
  static  List<Marker> _markers = [
    LatLng(45.765225979906944, 21.23058855792415)
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
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
      return;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.deniedForever)
        return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(LatLng(position.latitude, position.longitude), 16.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:FlutterMap(
        options:  MapOptions(
          initialZoom: 14.6,
          initialCenter: _currentPosition ?? LatLng(45.75372,21.22571),
          onTap: (tapPos,latlng){ setState(() {
            _markers.add(
                Marker(point: latlng, child: Icon(Icons.location_on, size: 40))
            );
          });
          },
        ),
        mapController: _mapController,
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
          PolygonLayer(
            polygons: [
              Polygon(
                points: [LatLng(45.76494266773059, 21.229629518653113),LatLng(45.764994252131125, 21.231497866892592),LatLng(45.765613261215506, 21.231024617828815),LatLng(45.76543443704802, 21.229649237442477)
                ],
                color: Colors.lightGreen.withAlpha(128),
                borderColor: Colors.green,

              ),

            ],
          ),
          if (_currentPosition != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentPosition!,
                  width: 80,
                  height: 80,
                  child: Icon(Icons.my_location_rounded, color: Colors.blue, size: 25),
                ),
              ],
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
      ),
        floatingActionButton:  FloatingActionButton(
            onPressed: _determinePosition,
            child: Icon(Icons.my_location),
        ),
    );
  }
}

