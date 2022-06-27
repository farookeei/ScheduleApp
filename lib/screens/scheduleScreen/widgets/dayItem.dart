import 'package:flutter/material.dart';

import '../../../core/services/dependecyInjection.dart';
import '../../../core/themes/colors.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class DayItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final Function()? onpressed;
  // ignore: use_key_in_widget_constructors
  const DayItem(
      {required this.date,
      required this.onpressed,
      required this.day,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        // height: 60,
        //  width: 50,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              day,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            isSelected
                ? Container(
                    //  padding:
                    //  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: _colors.blueSecondayColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .merge(TextStyle(color: _colors.backgroundColor)),
                      ),
                    ),
                  )
                : Container(
                    width: 35,
                    height: 35,
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        date,
                        style: Theme.of(context).textTheme.headline6!,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
