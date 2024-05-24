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
        // on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
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
            ),
            onError: (_, __) => state.copyWith(
                status: () => TodosOverviewStatus.failure,
            ),
        );
    }
}