
part of 'todos_overview_bloc.dart';
sealed class TodosOverviewEvent extends Equatable{
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}
final class TodosOverviewSubscriptionRequested extends TodosOverviewEvent {
  const TodosOverviewSubscriptionRequested();
}

final class TodosOverviewTodoCompletionToggled extends TodosOverviewEvent {
  const TodosOverviewTodoCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}

final class TodosOverviewTodoDeleted extends TodosOverviewEvent {
  const TodosOverviewTodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodosOverviewUndoDeletionRequested extends TodosOverviewEvent {
  const TodosOverviewUndoDeletionRequested();
}

class TodosOverviewFilterChanged extends TodosOverviewEvent {
  const TodosOverviewFilterChanged(this.filter);

  final TodosViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class TodosOverviewToggleAllRequested extends TodosOverviewEvent {
  const TodosOverviewToggleAllRequested();
}

class TodosOverviewClearCompletedRequested extends TodosOverviewEvent {
  const TodosOverviewClearCompletedRequested();
}

class TodosClicked extends TodosOverviewEvent {
  const TodosClicked(this.todo);

  final Todo todo;
  @override
  List<Object> get props => [todo];
}



class TodoSubTodosShow extends TodosOverviewEvent {
const TodoSubTodosShow(this.todo);

final Todo todo;
@override
List<Object> get props => [todo];
}

class TodoAddTagEvent extends TodosOverviewEvent {
  const TodoAddTagEvent(this.todo, this.tag);

  final Todo todo;
  final String tag;
  @override
  List<Object> get props => [todo, tag];
}

class TodoRemoveTagEvent extends TodosOverviewEvent {
  const TodoRemoveTagEvent(this.todo, this.tag);

  final Todo todo;
  final String tag;
  @override
  List<Object> get props => [todo, tag];
}

  class TodoAddSubTodo extends TodosOverviewEvent {
  const TodoAddSubTodo(this.parentTodo, this.subTudo);

  final Todo parentTodo;
  final Todo subTudo;
  @override
  List<Object> get props => [parentTodo, subTudo];
}

class TodoSetTagFilter extends TodosOverviewEvent {
  const TodoSetTagFilter(this.tagFilter);

  final String tagFilter;
  @override
  List<Object> get props => [tagFilter];
}

class TodoAddTodo extends TodosOverviewEvent {
const TodoAddTodo(this.todoName, this.tags);

final String todoName;
final List<String> tags;
@override
List<Object> get props => [todoName, tags];
}

