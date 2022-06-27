import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../../core/services/dependecyInjection.dart';
import '../../../core/themes/colors.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class PerdayScheduleListIem extends StatelessWidget {
  final String name;
  final String startTime;
  final String endTime;
  final bool isFinalItem;

  // ignore: use_key_in_widget_constructors
  const PerdayScheduleListIem(
      {required this.isFinalItem,
      required this.name,
      required this.endTime,
      required this.startTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  isFinalItem
                      ? SizedBox.shrink()
                      : const Positioned(
                          bottom: -50,
                          left: 32,
                          // right: 30,
                          //  alignment: Alignment.centerLeft,
                          child: DottedLine(
                            direction: Axis.vertical,
                            lineLength: 70,
                            lineThickness: 4.0,
                            dashLength: 5.0,
                            dashColor: Colors.black,
                            // dashGradient: [Colors.red, Colors.blue],
                            dashRadius: 0.0,
                            dashGapLength: 6.0,
                            dashGapColor: Colors.transparent,
                            //dashGapGradient: [Colors.red, Colors.blue],
                            dashGapRadius: 0.0,
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 100,
                    width: 70,
                    decoration: BoxDecoration(
                        color: _colors.lightblueColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Image.asset(
                      "assets/images/calendar.png",
                      scale: 2.2,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$startTime - $endTime",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 5),
              Text(
                name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
