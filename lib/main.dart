import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:scheduleapp/screens/scheduleScreen/scheduleScreen.dart';

import 'core/bloc/FetchBloc/schedule_bloc.dart';
import 'core/bloc/SaveBloc/saveapi_bloc.dart';
import 'core/services/dependecyInjection.dart';
import 'core/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  serviceLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<ScheduleBloc>(create: (context) => ScheduleBloc()),
          BlocProvider<SaveapiBloc>(create: (context) => SaveapiBloc()),
        ],
        // create: (context) => ScheduleBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Schedule app',
          theme: themes(),
          home: const ScheduleScreen(),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
