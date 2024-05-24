import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:myfirstflutterproject/Repositories/todos_repository.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/models/todo.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/models/todos_view_filter.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';



class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
    TodosOverviewBloc({
        required TodosRepository todosRepository,
    })  : _todosRepository = todosRepository,
            super(const TodosOverviewState()) {
         on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
         on<TodosClicked>(_todoClicked);
         //on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
        // on<TodosOverviewTodoDeleted>(_onTodoDeleted);
        // on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
        // on<TodosOverviewFilterChanged>(_onFilterChanged);
        // on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
        // on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
    }
    final TodosRepository _todosRepository;

    Future<void> _onSubscriptionRequested(
        TodosOverviewSubscriptionRequested event,
        Emitter<TodosOverviewState> emit,
        ) async {
        emit(state.copyWith(status: () => TodosOverviewStatus.loading));

        await emit.forEach<List<Todo>>(
            _todosRepository.getTodos(),
            onData: (todos) => state.copyWith(
                status: () => TodosOverviewStatus.success,
                todos: () => todos,
                //todos: () => _mockTodos,
            ),
            onError: (_, __) => state.copyWith(
                status: () => TodosOverviewStatus.failure,
            ),
        );
    }

    Future<void> _todoClicked(
        TodosClicked event,
        Emitter<TodosOverviewState> emit,
        ) async {
        print(" haha buzi vagy ${event.todo.title}");
    }
}


List<Todo> _mockTodos = [
    Todo(title: "title1", id: "1", description: "my first description1", isCompleted: false),
    Todo(title: "title2", id: "2", description: "my first description2", isCompleted: false),
    Todo(title: "title3", id: "3", description: "my first description3", isCompleted: false),
    Todo(title: "title4", id: "4", description: "my first description4", isCompleted: true),
    Todo(title: "title5", id: "5", description: "my first description5", isCompleted: false),
    Todo(title: "title6", id: "6", description: "my first description6", isCompleted: false),
];