import 'package:flutter/material.dart';
import 'package:scheduleapp/core/themes/colors.dart';

import '../services/dependecyInjection.dart';

ColorSchemes _colors = locator<ColorSchemes>();

TextTheme textTheme() => TextTheme(
    headline6: TextStyle(
        fontFamily: "Euclid Circular B",
        fontSize: 16,
        color: _colors.black,
        fontWeight: FontWeight.w500),
    bodyText1: TextStyle(
        fontFamily: "Euclid Circular B",
        fontSize: 12,
        color: _colors.black,
        fontWeight: FontWeight.w500));
