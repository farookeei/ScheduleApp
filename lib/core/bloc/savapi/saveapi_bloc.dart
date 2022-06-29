import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/scheduleApis.dart';

part 'saveapi_event.dart';
part 'saveapi_state.dart';

class SaveapiBloc extends Bloc<SaveapiEvent, SaveapiState> {
  SaveapiBloc() : super(SaveapiInitial(isApiPosting: false)) {
    on<SaveApiEvent>((event, emit) async {
      try {
        emit(SaveapiInitial(isApiPosting: true));
        log("savemessage1");

        await ScheduleApi.createSchedules(
            event.name, event.date, event.starttime, event.endtime);

        log("savemessage2");
        emit(SaveapiInitial(isApiPosting: false));
      } catch (e) {
        log("error in bloc");

        emit(SaveapiInitial(isApiPosting: false));
        // ignore: use_rethrow_when_possible
        // throw e;
      }
    });
  }
}
