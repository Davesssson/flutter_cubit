// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String,
      id: json['id'] as String?,
      description: json['description'] as String? ?? "",
      isCompleted: json['isCompleted'] as bool? ?? false,
      childIds: (json['childIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
      isSubTodo: json['isSubTodo'] as bool,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isSubTodo': instance.isSubTodo,
      'childIds': instance.childIds,
      'tags': instance.tags.toList(),
    };
