import 'package:carspace/models/ReservationModel.dart';
import 'package:carspace/widgets/ReservationView.dart';
import 'package:flutter/material.dart';


class ReservationTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CustomScrollViewExample());
  }
}

class CustomScrollViewExample extends StatefulWidget {
  const CustomScrollViewExample({super.key});

  @override
  State<CustomScrollViewExample> createState() =>
      _CustomScrollViewExampleState();
}

class _CustomScrollViewExampleState extends State<CustomScrollViewExample> {
  List<Widget> reservations = [];

  @override
  Widget build(BuildContext context) {
   // const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Press on the plus to add items above and below'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              reservations.add(ReservationsView(reservation: ReservationModel(title: "Example", start: DateTime.now(), duration: Duration(hours:2))));
            });
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: reservations
      )
    );
  }
}

