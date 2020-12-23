// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drive _$DriveFromJson(Map<String, dynamic> json) {
  return Drive(
    id: json['id'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    skills: json['skills'] as String,
    minutesDriven: (json['minutes-driven'] as num)?.toDouble(),
    milesDriven: (json['miles-driven'] as num)?.toDouble(),
    minutesDrivenNight: (json['minutes-driven-at-night'] as num)?.toDouble(),
    comments: json['comments'] as String,
  );
}

Map<String, dynamic> _$DriveToJson(Drive instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'skills': instance.skills,
      'minutes-driven': instance.minutesDriven,
      'miles-driven': instance.milesDriven,
      'minutes-driven-at-night': instance.minutesDrivenNight,
      'comments': instance.comments,
    };
