import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/scheduleApis.dart';

part 'saveapi_event.dart';
part 'saveapi_state.dart';

class SaveapiBloc extends Bloc<SaveapiEvent, SaveapiState> {
  SaveapiBloc() : super(SaveapiInitial(isApiPosting: false, isError: false)) {
    on<SaveApiEvent>((event, emit) async {
      try {
        emit(SaveapiInitial(isApiPosting: true, isError: false));
        await ScheduleApi.createSchedules(
            event.name, event.date, event.starttime, event.endtime);
        emit(SaveapiInitial(isApiPosting: false));
      } catch (e) {
        emit(SaveapiInitial(isApiPosting: false, isError: true));
      }
    });
  }
}
