part of 'saveapi_bloc.dart';

class SaveapiState {
  final bool isApiPosting;
  SaveapiState({required this.isApiPosting});
}

class SaveapiInitial extends SaveapiState {
  SaveapiInitial({required bool isApiPosting})
      : super(isApiPosting: isApiPosting);
}
