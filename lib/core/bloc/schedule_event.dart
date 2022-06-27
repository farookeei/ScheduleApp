part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class FetchApiEvent extends ScheduleEvent {}

class SaveApiEvent extends ScheduleEvent {
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
