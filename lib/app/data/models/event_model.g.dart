// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModelTeste _$EventModelTesteFromJson(Map<String, dynamic> json) =>
    EventModelTeste(
      (json['id'] as num).toInt(),
      (json['changed'] as num).toInt(),
      (json['status'] as num).toInt(),
      (json['weight'] as num).toInt(),
      json['addons'],
      json['parent'],
      json['event'] as String,
      json['papers'] as List<dynamic>,
      json['title'] as Map<String, dynamic>,
      json['description'] as Map<String, dynamic>,
      DateTime.parse(json['start'] as String),
      DateTime.parse(json['end'] as String),
      json['category'] as Map<String, dynamic>,
      (json['locations'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      json['type'] as Map<String, dynamic>,
      (json['people'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$EventModelTesteToJson(EventModelTeste instance) =>
    <String, dynamic>{
      'id': instance.id,
      'changed': instance.changed,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'locations': instance.locations,
      'type': instance.type,
      'papers': instance.papers,
      'people': instance.people,
      'status': instance.status,
      'weight': instance.weight,
      'addons': instance.addons,
      'parent': instance.parent,
      'event': instance.event,
    };
