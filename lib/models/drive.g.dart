// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drive _$DriveFromJson(Map<String, dynamic> json) {
  return Drive(
    minutesDriven: (json['minutes-driven'] as num)?.toDouble(),
    minutesDrivenNight: (json['minutes-driven-at-night'] as num)?.toDouble(),
    milesDriven: (json['miles-driven'] as num)?.toDouble(),
    skillsWorkedOn: json['skills'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$DriveToJson(Drive instance) => <String, dynamic>{
      'minutes-driven': instance.minutesDriven,
      'minutes-driven-at-night': instance.minutesDrivenNight,
      'miles-driven': instance.milesDriven,
      'skills': instance.skillsWorkedOn,
      'date': instance.date?.toIso8601String(),
    };
