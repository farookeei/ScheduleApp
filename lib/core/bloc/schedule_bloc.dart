import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scheduleapp/core/model/scheduleModel.dart';

import '../repository/scheduleApis.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial(isApifeching: true)) {
    on<FetchApiEvent>((event, emit) async {
      emit(ScheduleState(
        isApifeching: true,
      ));
      log("message1");
      final data = await ScheduleApi.fetchSchedules();
      log("message2");
      emit(ScheduleState(isApifeching: false, schedulelist: data));
    });

    // on<SaveApiEvent>((event, emit) async {
    //   try {
    //     emit(ScheduleState(
    //       isApifeching: true,
    //     ));
    //     log("savemessage1");

    //     await ScheduleApi.createSchedules(
    //         event.name, event.date, event.starttime, event.endtime);

    //     log("savemessage2");
    //     emit(ScheduleState(isApifeching: false));
    //   } catch (e) {
    //     log("error in bloc");
    //     emit(ScheduleState(isApifeching: false));
    //   }
    // });
  }
}
