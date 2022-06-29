import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scheduleapp/core/model/scheduleModel.dart';

import '../../repository/scheduleApis.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial(isApifeching: true)) {
    on<FetchApiEvent>((event, emit) async {
      emit(ScheduleState(
        isApifeching: true,
      ));
      final data = await ScheduleApi.fetchSchedules();
      emit(ScheduleState(isApifeching: false, schedulelist: data));
    });
  }
}
