import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:myfirstflutterproject/ui/todo/add_new_todo_bottom_sheet/bloc/add_new_todo_event.dart';
import 'package:myfirstflutterproject/ui/todo/add_new_todo_bottom_sheet/bloc/add_new_todo_state.dart';




class AddNewTodoBloc extends Bloc<AddNewTodoEvent, AddNewTodoState> {
  AddNewTodoBloc() : super(const AddNewTodoState(
    selectedTags: []
  )){
    on<TodoAddNewTodoTag>(_addTagToNewTodo);
  }

  Future<void> _addTagToNewTodo(
      TodoAddNewTodoTag event,
      Emitter<AddNewTodoState> emit,
      ) async {
    print("ez van eloszor");
    print(state.selectedTags);
    List<String> updatedTags = List.from(state.selectedTags);
    updatedTags.add(event.tag); // Add the new tag to the growable list

    emit(state.copyWith(selectedTags: ()=> updatedTags));
    print("ez van masodijara");
    print(state.selectedTags);

  }
}

