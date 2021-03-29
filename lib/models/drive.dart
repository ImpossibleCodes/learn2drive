import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'drive.g.dart';

@immutable
@JsonSerializable()
class Drive {
  final String id;
  final DateTime date;
  final String skills;
  @JsonKey(name: 'minutes-driven')
  final int minutesDriven;
  @JsonKey(name: 'miles-driven')
  final double milesDriven;
  @JsonKey(name: 'minutes-driven-at-night')
  final int minutesDrivenNight;
  final String comments;

  Drive({
    @required this.id,
    @required this.date,
    @required this.skills,
    @required this.minutesDriven,
    @required this.milesDriven,
    @required this.minutesDrivenNight,
    this.comments,
  });

  @override
  bool operator ==(Object other) =>
      other is Drive &&
      other.id == id &&
      other.date == date &&
      other.skills == skills &&
      other.minutesDriven == minutesDriven &&
      other.milesDriven == milesDriven &&
      other.minutesDrivenNight == minutesDrivenNight &&
      other.comments == comments;

  @override
  int get hashCode => hashValues(id, date, skills, minutesDriven, milesDriven,
      minutesDrivenNight, comments);

  factory Drive.fromJson(Map<String, dynamic> json) => _$DriveFromJson(json);

  Map<String, dynamic> toJson() => _$DriveToJson(this);
}
