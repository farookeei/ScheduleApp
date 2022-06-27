import 'package:flutter/material.dart';

import 'primaryTexttheme.dart';
import 'text_theme.dart';

ThemeData themes() {
  return ThemeData(
      fontFamily: "Euclid Circular B",
      textTheme: textTheme(),
      primaryTextTheme: primarytextTheme());
}
