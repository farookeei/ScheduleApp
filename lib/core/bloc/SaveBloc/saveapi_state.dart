part of 'saveapi_bloc.dart';

class SaveapiState {
  final bool isApiPosting;
  final bool isError;
  SaveapiState({required this.isApiPosting, this.isError = false});
}

class SaveapiInitial extends SaveapiState {
  SaveapiInitial({required bool isApiPosting, bool isError = false})
      : super(isApiPosting: isApiPosting, isError: isError);
}
