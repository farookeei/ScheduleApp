import 'package:flutter/material.dart';

void snakBarNotification({
  required String notification,
  required GlobalKey<ScaffoldState> scaffoldkey,
}) {
  // ignore: deprecated_member_use
  scaffoldkey.currentState!.showSnackBar(SnackBar(
    content: Text(notification),
    duration: const Duration(seconds: 3),
  ));
}
