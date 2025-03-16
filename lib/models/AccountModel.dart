import 'ReservationModel.dart';

class User{
  final String name;
  final String email;
  List<ReservationModel> reservations;

  User({required this.name, required this.email, required this.reservations});

}