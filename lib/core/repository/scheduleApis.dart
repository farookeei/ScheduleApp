import 'dart:developer';

import 'package:scheduleapp/core/error/http_exception.dart';
import 'package:scheduleapp/core/model/scheduleModel.dart';
import 'package:scheduleapp/core/services/dependecyInjection.dart';

import '../services/dio_services_API.dart';
import 'package:dio/dio.dart';

DioAPIServices _dioAPIServices = locator<DioAPIServices>();

class ScheduleApi {
  static Future<List<ScheduleModel>> fetchSchedules() async {
    try {
      List<ScheduleModel> _scheduleList = [];

      final Response response = await Dio(BaseOptions())
          .get("https://alpha.classaccess.io/api/challenge/v1/schedule");
      for (var _item in response.data["data"]) {
        _scheduleList.add(ScheduleModel.convert(_item)!);
      }
      log(_scheduleList[0].date);
      return _scheduleList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<void> createSchedules(
      String name, String date, String starttime, String endtime) async {
    try {
      final _fetchData = _dioAPIServices.postAPI(
          url: "https://alpha.classaccess.io/api/challenge/v1/save/schedule",
          body: {
            "name": name,
            "startTime": starttime,
            "endTime": endtime,
            "date": date
          });

      // final Response response = await Dio(BaseOptions()).post(
      //     "https://alpha.classaccess.io/api/challenge/v1/save/schedule",
      //     options: Options(contentType: "application/json"),
      //     data: {
      //       "name": name,
      //       "startTime": starttime,
      //       "endTime": endtime,
      //       "date": date
      //     });

      // if (response.data is Map) {
      //   if (response.data.containsKey('errors'))
      //     // ignore: curly_braces_in_flow_control_structures
      //     throw HttpException(response.data['errors'][0], response.statusCode!);
      // }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
