part of 'saveapi_bloc.dart';

@immutable
abstract class SaveapiEvent {}

class SaveApiEvent extends SaveapiEvent {
  final String name;
  final String starttime;
  final String endtime;
  final String date;

  SaveApiEvent(
      {required this.date,
      required this.endtime,
      required this.name,
      required this.starttime});
}
