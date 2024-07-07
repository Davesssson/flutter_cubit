
import 'package:equatable/equatable.dart';


sealed class AddNewTodoEvent extends Equatable{
  const AddNewTodoEvent();

  @override
  List<Object> get props => [];
}


class TodoAddNewTodoTag extends AddNewTodoEvent {
  const TodoAddNewTodoTag(this.tag);
  final String tag;

  @override
  List<Object> get props => [tag];
}
