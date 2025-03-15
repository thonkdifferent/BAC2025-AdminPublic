import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import '../widgets/ParkingMap.dart';
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
      body: ParkingMap()
    );
  }
}