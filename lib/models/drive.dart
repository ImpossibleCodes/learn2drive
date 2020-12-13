import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

part 'drive.g.dart';

@immutable
@JsonSerializable()
class Drive {
  @JsonKey(name: 'minutes-driven')
  final double minutesDriven;
  @JsonKey(name: 'minutes-driven-at-night')
  final double minutesDrivenNight;
  @JsonKey(name: 'miles-driven')
  final double milesDriven;
  @JsonKey(name: 'skills')
  final String skillsWorkedOn;
  final DateTime date;

  Drive({
    @required this.minutesDriven,
    @required this.minutesDrivenNight,
    @required this.milesDriven,
    @required this.skillsWorkedOn,
    @required this.date,
  });

  @override
  bool operator ==(Object other) =>
      other is Drive &&
      other.minutesDriven == minutesDriven &&
      other.minutesDrivenNight == minutesDrivenNight &&
      other.milesDriven == milesDriven &&
      other.skillsWorkedOn == skillsWorkedOn &&
      other.date == date;

  @override
  int get hashCode => hashValues(
      minutesDriven, minutesDrivenNight, milesDriven, skillsWorkedOn, date);

  factory Drive.fromJson(Map<String, dynamic> json) => _$DriveFromJson(json);

  Map<String, dynamic> toJson() => _$DriveToJson(this);
}
