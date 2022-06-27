part of 'schedule_bloc.dart';

class ScheduleState {
  final bool isApifeching;
  final List<ScheduleModel>? schedulelist;

  ScheduleState({required this.isApifeching, this.schedulelist});
}

class ScheduleInitial extends ScheduleState {
  // ScheduleInitial({required super.isApiFetching})
  ScheduleInitial({required bool isApifeching})
      : super(isApifeching: isApifeching);
}
