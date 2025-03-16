import 'package:flutter/material.dart';
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