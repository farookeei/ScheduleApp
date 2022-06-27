class ScheduleModel {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String date;

  ScheduleModel(
      {required this.date,
      required this.endTime,
      required this.id,
      required this.name,
      required this.startTime});

  static ScheduleModel? convert(Map data) {
    if (data == null) return null;

    return ScheduleModel(
        date: data["date"] == null ? "" : data["date"],
        endTime: data["endTime"] == null ? "" : data["endTime"],
        id: data["_id"] == null ? "" : data["_id"],
        name: data["name"] == null ? "" : data["name"],
        startTime: data["startTime"] == null ? "" : data["startTime"]);
  }
}
