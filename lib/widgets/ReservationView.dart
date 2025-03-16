import 'package:carspace/models/ReservationModel.dart';
import 'package:flutter/material.dart';

class ReservationsView extends StatelessWidget{


  final ReservationModel reservation;
  const ReservationsView({super.key, required this.reservation});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Text(reservation.title),
          Row(
            children: [
              Text(reservation.start.toString()),
              Text(" - "),
              Text(reservation.end.toString())
            ],
          ),
          OutlinedButton(
            onPressed: () {

            },
            child: Text("asadasdads")
          )
        ],
      ),
    );
  }
}