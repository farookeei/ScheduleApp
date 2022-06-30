import 'package:flutter/material.dart';
import 'package:scheduleapp/core/services/dependecyInjection.dart';
import 'package:scheduleapp/core/themes/colors.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class DateAndTime extends StatelessWidget {
  final Function()? onpressed;
  final String title;
  final String value;
  final bool isTimeeValid;
  final bool isDateWidget;

  // ignore: use_key_in_widget_constructors
  const DateAndTime(
      {this.onpressed,
      required this.isTimeeValid,
      required this.isDateWidget,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).primaryTextTheme.headline6),
          InkWell(
            onTap: onpressed,
            child: Row(
              children: [
                Text(value,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline6!
                        .merge(TextStyle(color: _colors.blueSecondayColor))),
                !isDateWidget
                    ? isTimeeValid
                        ? const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          )
                        : const Icon(
                            Icons.warning,
                            size: 18,
                          )
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
