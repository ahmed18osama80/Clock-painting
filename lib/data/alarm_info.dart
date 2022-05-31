import 'dart:ui';

class AlarmInfo {
  int? id;
  String title;
  DateTime alarmDateTime;
  bool? isPending;
  int gradientColorIndex;
  List<Color>? gradientColors;

  AlarmInfo(
      {this.id,
       this.gradientColors,
      required this.title,
      required this.alarmDateTime,
      this.isPending,
      required this.gradientColorIndex});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
        gradientColors: json["gradientColors"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
        "gradientColors": gradientColors
      };
}
