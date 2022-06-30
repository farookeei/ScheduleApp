import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scheduleapp/core/model/scheduleModel.dart';
import 'package:scheduleapp/screens/bottomsheet/widgets/dateandTime.dart';
import 'package:scheduleapp/screens/bottomsheet/widgets/scheduleOverlap.dart';
import 'package:scheduleapp/widgets/customBtn.dart';
import 'package:date_format/date_format.dart';
import '../../core/bloc/FetchBloc/schedule_bloc.dart';
import '../../core/bloc/SaveBloc/saveapi_bloc.dart';

import '../../core/services/dependecyInjection.dart';
import '../../core/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/customDivider.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TimeOfDay selectedStartTime;
  late TimeOfDay selectedEndTime;
  late DateTime today;
  String? dateFormated;
  String? _name;
  bool _isLoading = false;
  bool _isTimeValid = true;

  String? finalStartTime;
  String? finalEndTime;

  void alertDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return const ScheduleOverlap();
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    selectedStartTime = TimeOfDay.now();
    today = DateTime.now();
    dateFormated = formatDate(today, [dd, '/', mm, '/', yyyy]);
    DateTime customDateTime = DateTime(today.year, today.month, today.day,
        selectedStartTime.hour, selectedStartTime.minute);
    selectedEndTime =
        TimeOfDay.fromDateTime(customDateTime.add(const Duration(minutes: 30)));
    //? converting final time
    convertingTime(selectedStartTime, selectedEndTime);
    super.initState();
  }

  void convertingTime(TimeOfDay _starttime, TimeOfDay _endTime) {
    finalStartTime =
        "${_starttime.hour.toString()}:${_starttime.minute.toString()}:00";
    finalEndTime =
        "${_endTime.hour.toString()}:${_endTime.minute.toString()}:00";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        today = picked;
        dateFormated = formatDate(today, [dd, '/', mm, '/', yyyy]);
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool startTime) async {
    if (startTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedStartTime,
      );
      if (pickedTime != null && pickedTime != selectedStartTime) {
        setState(() => selectedStartTime = pickedTime);
      }
      //selectedStartTime.format(context);
      final localizations = MaterialLocalizations.of(context);
      final formattedTimeOfDay = selectedStartTime.format(context);
      // localizations.formatTimeOfDay(selectedStartTime);
      //? converting final time
      convertingTime(selectedStartTime, selectedEndTime);

      print(selectedStartTime);
      print(formattedTimeOfDay);
    } else {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedEndTime,
      );
      if (pickedTime != null && pickedTime != selectedStartTime) {
        setState(() => selectedEndTime = pickedTime);
      }
      //? converting final time
      convertingTime(selectedStartTime, selectedEndTime);
    }
  }

  TimeOfDay stringToTimeOfDay(String s) {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    return _startTime;
  }

  bool timedifference() {
    TimeOfDay a = selectedStartTime;
    int firstTime = a.hour * 60 + a.minute;

    TimeOfDay b = selectedEndTime;
    int secondTime = b.hour * 60 + b.minute;

    if (firstTime < secondTime) {
      setState(() {
        _isTimeValid = true;
      });
      return true;
    }
    return false;
  }

//* checking whether a point of time comes within a time range
  bool isValidTimeRange(
      TimeOfDay startTime, TimeOfDay endTime, TimeOfDay comparesTo) {
    TimeOfDay now = comparesTo;
    return ((now.hour > startTime.hour) ||
            (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
        ((now.hour < endTime.hour) ||
            (now.hour == endTime.hour && now.minute <= endTime.minute));
  }

  Future<void> submitSchedule(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    //* checking whether the start time is less than endtime
    bool isTimeCorrect = timedifference();
    if (!isTimeCorrect) {
      setState(() {
        _isTimeValid = false;
      });
      return;
    }

    List<ScheduleModel>? _scheduleModel = [];
    _scheduleModel = BlocProvider.of<ScheduleBloc>(context, listen: false)
        .state
        .schedulelist;
    for (int i = 0; i < _scheduleModel!.length; i++) {
      if (_scheduleModel[i].date == dateFormated) {
        bool a = isValidTimeRange(selectedStartTime, selectedEndTime,
            stringToTimeOfDay(_scheduleModel[i].startTime));
        bool b = isValidTimeRange(selectedStartTime, selectedEndTime,
            stringToTimeOfDay(_scheduleModel[i].endTime));

        if (a || b) {
          return alertDialog(context);
        }
      }
      i++;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      BlocProvider.of<SaveapiBloc>(context, listen: false).add(SaveApiEvent(
          date: dateFormated!,
          endtime: finalEndTime!,
          name: _name!,
          starttime: finalStartTime!));

      await Future.delayed(const Duration(milliseconds: 1000));

      if (BlocProvider.of<SaveapiBloc>(context, listen: false).state.isError) {
        setState(() {
          _isLoading = false;
        });
        return alertDialog(context);
      }

      BlocProvider.of<ScheduleBloc>(context, listen: false)
          .add(FetchApiEvent());
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      alertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Schedule",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(color: _colors.blueCaptioncolor)),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 20),
            Text("Name", style: Theme.of(context).textTheme.headline6),
            TextFormField(
                onSaved: (_val) {
                  _name = _val;
                },
                validator: (_val) {
                  if (_val!.isEmpty || _val.trim().length <= 3) {
                    return "Enter a valid name";
                  }
                },
                decoration: InputDecoration(
                  // hintText: "Name",
                  //label: Text("Name"),
                  filled: true,
                  // enabled: false,
                  fillColor: _colors.textformfieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none,
                  ),
                )),
            const SizedBox(height: 15),
            Text("Date & time", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 5),

            // ignore: avoid_unnecessary_containers
            Container(
              decoration: BoxDecoration(
                color: _colors.textformfieldColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                children: [
                  DateAndTime(
                      title: "Start Time",
                      isDateWidget: false,
                      isTimeeValid: _isTimeValid,
                      value: selectedStartTime.format(context),
                      onpressed: () {
                        _selectTime(context, true);
                      }),
                  const CustomDivider(),
                  DateAndTime(
                      title: "End Time",
                      isDateWidget: false,
                      isTimeeValid: _isTimeValid,
                      // ignore: unnecessary_null_comparison
                      value: selectedEndTime == null
                          ? ""
                          : selectedEndTime.format(context),
                      onpressed: () {
                        _selectTime(context, false);
                      }),
                  const CustomDivider(),
                  DateAndTime(
                      title: "Date",
                      isDateWidget: true,
                      isTimeeValid: _isTimeValid,
                      value: dateFormated!,
                      onpressed: () {
                        _selectDate(context);
                      }),
                ],
              ),
            ),
            const SizedBox(height: 15),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomBtn(
                    title: "Add Schedule",
                    onpressed: () {
                      submitSchedule(context);
                    },
                  ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
