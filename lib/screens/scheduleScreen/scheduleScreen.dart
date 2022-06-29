// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:scheduleapp/core/bloc/schedule_bloc.dart';
import 'package:scheduleapp/core/themes/colors.dart';
import 'package:scheduleapp/core/values/days.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/dependecyInjection.dart';

import '../bottomsheet/bottomsheet.dart';
import 'widgets/dayItem.dart';
import 'widgets/perdaySchedule.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var _selectedDate = "";
  bool _isSelected = false;
  bool nothing = false;
  int count = 0;

  void fetchSchedules(BuildContext context) {
    log("starting");
    context.read<ScheduleBloc>().add(FetchApiEvent());
  }

  @override
  void didChangeDependencies() {
    if (count == 0) {
      fetchSchedules(context);
      count++;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //days

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: _colors.blueSecondayColor,
          onPressed: () {
            showModalBottomSheet(
                //isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (ctx) {
                  return StatefulBuilder(builder: (ctx, setState) {
                    return CustomBottomSheet();
                  });
                });
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "JUNE 2022",
                    style: Theme.of(context).textTheme.headline6,
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.only(
                  left: 5,
                ),
                child: ListView.builder(
                  itemBuilder: (ctx, i) {
                    return DayItem(
                      date: Days[i]["date"].toString().split('/').first,
                      day: Days[i]["day"].toString(),
                      isSelected: Days[i]["isSelected"],
                      onpressed: () {
                        for (int a = 0; a < Days.length; a++) {
                          if (a == i) continue;
                          Days[a]["isSelected"] = false;
                        }
                        Days[i]["isSelected"] = true;
                        //****** */
                        _selectedDate = Days[i]["date"];
                        setState(() {});
                      },
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Days.length,
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                      color: _colors.secondarybackgroundColor,
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: BlocBuilder<ScheduleBloc, ScheduleState>(
                    builder: (context, state) {
                      if (state.isApifeching) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // else {
                      return ListView.builder(
                        // ignore: prefer_if_null_operators
                        itemCount: state.schedulelist?.length,
                        itemBuilder: (ctx, i) {
                          if (_selectedDate == state.schedulelist?[i].date) {
                            return PerdayScheduleListIem(
                              isFinalItem: i + 1 == state.schedulelist!.length
                                  ? true
                                  : false,
                              // ignore: prefer_if_null_operators
                              name: state.schedulelist![i].name == null
                                  ? ""
                                  : state.schedulelist![i].name,
                              // ignore: unnecessary_null_comparison
                              startTime: state.schedulelist![i].startTime ==
                                      null
                                  ? ""
                                  : DateFormat.jm().format(
                                      DateFormat("hh:mm:ss").parse(
                                          state.schedulelist![i].startTime)),
                              endTime: state.schedulelist![i].startTime == null
                                  ? ""
                                  : DateFormat.jm().format(
                                      DateFormat("hh:mm:ss").parse(
                                          state.schedulelist![i].endTime)),
                            );
                          }
                          return SizedBox.shrink();
                        },
                        shrinkWrap: true,
                      );
                      //  }
                      // return ListView.builder(
                      //   itemCount: 3,
                      //   itemBuilder: (ctx, i) {
                      //     return PerdayScheduleListIem();
                      //   },
                      //   shrinkWrap: true,
                      // );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
