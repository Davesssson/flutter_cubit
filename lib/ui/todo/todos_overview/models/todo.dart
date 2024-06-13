import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable{
  Todo({
    required this.title,
    String? id,
    this.description = "",
    this.isCompleted = false,
    this.childIds = const [],
    this.tags = const {},
    required this.isSubTodo
  }) : assert(
      id == null || id.isNotEmpty , "id must be either be null or not empty"
  ), id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isSubTodo;
  final List<String> childIds;
  Set<String> tags;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isSubTodo,
    List<String>? childIds,
    Set<String>? tags,

  }) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        childIds: childIds ?? this.childIds,
        tags: tags ?? this.tags,
        isSubTodo: isSubTodo ?? this.isSubTodo,
    );
  }

  static Todo fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [id, title, description, isCompleted, childIds, tags];

}