

import 'package:equatable/equatable.dart';


final class AddNewTodoState extends Equatable {
  const AddNewTodoState(
      {
      this.selectedTags = const [],
      });


  final List<String> selectedTags;

  AddNewTodoState copyWith(
      {
      List<String> Function()? selectedTags,
      }
      ) {
    return AddNewTodoState(
    selectedTags: selectedTags != null ? selectedTags() : this.selectedTags,
    );
  }

  @override
  List<Object?> get props => [
      selectedTags,
    ];
}
