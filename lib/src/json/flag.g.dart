// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flag _$FlagFromJson(Map<String, dynamic> json) => Flag(
      name: json['name'] as String,
      description: json['description'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$FlagToJson(Flag instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
    };
