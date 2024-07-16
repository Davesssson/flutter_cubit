
part of 'todos_overview_bloc.dart';



enum TodosOverviewStatus {initial, loading, success, failure}

final class TodosOverviewState extends Equatable{
  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const [],
    this.filter = TodosViewFilter.all,
    this.tagFilter = const {},
    this.lastDeletedTodo,
    this.showChildren = const [],
    this.userTodoTags = const {},
    this.newTodoSelectedTags = const {}
  });

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final Set<String> tagFilter;
  final Todo? lastDeletedTodo;
  final List<String> showChildren;
  final Set<String> userTodoTags;
  final Set<String> newTodoSelectedTags;

Iterable<Todo> get filteredTodos => filter.applyAll(todos);

Iterable<Todo> get tagFilteredTodos  {
  if (this.tagFilter.isEmpty){ return this.todos;}
  List<Todo> todoss = [];
    for (final todo in this.todos){
      if (this.tagFilter.any((tagFilter) => todo.tags.contains(tagFilter)))
        todoss.add(todo);
    }
  print("TAGFILTERED_TODOS");
    //print(tagFilteredTodos);
  return todoss;
  
  
}

  TodosOverviewState copyWith({
    TodosOverviewStatus Function()? status,
    List<Todo> Function()? todos,
    TodosViewFilter Function()? filter,
    Set<String> Function()? tagFilter,
    Todo? Function()? lastDeletedTodo,
    List<String> Function()? showChildren,
    Set<String> Function()? userTodoTags,
    Set<String> Function()? newTodoSelectedTags
  }) {
    return TodosOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos(): this.todos,
      filter: filter != null ? filter() : this.filter,
      tagFilter: tagFilter != null ? tagFilter() : this.tagFilter,
      lastDeletedTodo: lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
      showChildren: showChildren != null ? showChildren(): this.showChildren,
      userTodoTags: userTodoTags != null ? userTodoTags(): this.userTodoTags,
      newTodoSelectedTags: newTodoSelectedTags != null ? newTodoSelectedTags(): this.newTodoSelectedTags,
    );
  }

  @override
  List<Object?> get props => [status, todos, filter, lastDeletedTodo, showChildren,userTodoTags, tagFilter, newTodoSelectedTags];

}