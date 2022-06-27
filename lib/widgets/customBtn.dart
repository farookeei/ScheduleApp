import 'package:flutter/material.dart';
import 'package:scheduleapp/core/themes/colors.dart';

import '../core/services/dependecyInjection.dart';

ColorSchemes _colors = locator<ColorSchemes>();

class CustomBtn extends StatelessWidget {
  final Function()? onpressed;
  final String title;

  // ignore: prefer_const_constructors_in_immutables
  CustomBtn({Key? key, this.onpressed, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      width: double.infinity,
      height: 50,
      child: TextButton(
          onPressed: onpressed,
          child: Text(title,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline6!
                  .merge(TextStyle(color: _colors.backgroundColor))),
          style: ButtonStyle(
            // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            //     EdgeInsets.symmetric(vertical: 10)),
            backgroundColor:
                MaterialStateProperty.all<Color>(_colors.blueSecondayColor),
            // foregroundColor: MaterialStateProperty.all<Color>(
            //     Theme.of(context).backgroundColor),
          )),
    );
  }
}
