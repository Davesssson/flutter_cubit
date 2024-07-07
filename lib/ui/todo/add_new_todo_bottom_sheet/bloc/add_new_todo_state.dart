

import 'package:equatable/equatable.dart';


final class AddNewTodoState extends Equatable {
  const AddNewTodoState(
      {
      this.selectedTags = const [],
      this.todoName = "",
      });


  final List<String> selectedTags;
  final String todoName;

  AddNewTodoState copyWith(
      {
      List<String> Function()? selectedTags,
      String?  todoName
      }
      ) {
    return AddNewTodoState(
    selectedTags: selectedTags != null ? selectedTags() : this.selectedTags,
    todoName: todoName ??  this.todoName,

    );
  }

  @override
  List<Object?> get props => [
      selectedTags,
todoName
    ];
}
