import 'package:flutter/material.dart';

import '../../../core/services/dependecyInjection.dart';
import '../../../core/themes/colors.dart';
import '../../../widgets/customBtn.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class ScheduleOverlap extends StatelessWidget {
  const ScheduleOverlap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0))),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "This overlaps with another schedule and can’t be saved.",
            style: Theme.of(context).textTheme.headline5!.merge(TextStyle(
                color: _colors.dangerColor, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 5),
          Text(
            "Please modify and try again.",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(color: _colors.blueSecondayColor)),
          ),
          const SizedBox(height: 15),
          CustomBtn(
            title: "Okay",
            onpressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
