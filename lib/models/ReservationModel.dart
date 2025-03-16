class ReservationModel{

  final String title;
  final DateTime start;
  final Duration duration;

  late DateTime end;

  ReservationModel({required this.title, required this.start, required this.duration}){
    end = start.add(duration);
  }
}