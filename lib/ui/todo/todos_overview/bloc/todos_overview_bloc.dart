import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
         on<TodoSubTodosShow>(_subTodoShow);
         on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
         on<TodoAddTagEvent>(_addTagToTodo);
         on<TodoRemoveTagEvent>(_removeTagFromTodo);
         on<TodoAddSubTodo>(_TodoAddSubTodo);
         on<TodoAddTodo>(_TodoAddTodo);
         on<TodoSetTagFilter>(_TodoSetTagFilter);
        // on<TodosOverviewTodoDeleted>(_onTodoDeleted);
        // on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
        // on<TodosOverviewFilterChanged>(_onFilterChanged);
        // on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
        // on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
    }
    final TodosRepository _todosRepository;

    List<Todo> getNestedTodos(String parentId) {
        List<Todo> nestedTodos = [];

        late Todo parentTodo;
        state.todos.toList().forEach((todo) {
            if (todo.id == parentId) parentTodo = todo;
        });
       //nestedTodos.add(parentTodo);
        parentTodo.childIds.forEach((id) {
            state.todos.toList().forEach((todo) {
                if (todo.id == id) nestedTodos.add(todo);
            });
        });

        for (String childId in parentTodo.childIds) {
            //nestedTodos.addAll(getNestedTodos(childId));
        }

        return nestedTodos;
    }

    Future<void> _onSubscriptionRequested(
        TodosOverviewSubscriptionRequested event,
        Emitter<TodosOverviewState> emit,
        ) async {
        emit(state.copyWith(status: () => TodosOverviewStatus.loading));

        await emit.forEach<List<Todo>>(
            _todosRepository.getTodos(),
            onData: (todos) =>  state.copyWith(
                status: () => TodosOverviewStatus.success,
                todos: () => todos,
                userTodoTags: () => returnSetFromTags(todos)
                //todos: () => _mockTodos,
            ),
            onError: (_, __) => state.copyWith(
                status: () => TodosOverviewStatus.failure,
            ),
        );
    }

    Set<String> returnSetFromTags(List<Todo> todos){
        Set<String> tags = {};
        for(var todo in todos) {
            for(var tag in todo.tags) {
                tags.add(tag);
            }
        }
        return tags;
    }

    Future<void> _onTodoCompletionToggled(
        TodosOverviewTodoCompletionToggled event,
        Emitter<TodosOverviewState> emit,
        ) async {
        final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
        List<Todo> list_without_old_todo = [];
        state.todos.toList().forEach((todo) {
            if (todo.id != event.todo.id) list_without_old_todo.add(todo);
        });
        list_without_old_todo.add(newTodo);

        emit(state.copyWith(todos: () => list_without_old_todo  ));
        await _todosRepository.saveTodo(newTodo);

    }

    Future<void> _todoClicked(
        TodosClicked event,
        Emitter<TodosOverviewState> emit,
        ) async {
        print(" haha buzi vagy ${event.todo.title}");
    }

    Future<void> _subTodoShow(
        TodoSubTodosShow event,
        Emitter<TodosOverviewState> emit,
        ) async {

        List<String> l = state.showChildren.toList();
        if(l.contains(event.todo.id)){
            // need to pop it
            l.remove(event.todo.id);
        }else
            // add it
            l.add(event.todo.id);

        emit(state.copyWith(showChildren: () => l  ));

    }

    Future<void> _addTagToTodo(
        TodoAddTagEvent event,
        Emitter<TodosOverviewState> emit,
        )async{
        //print(event.todo.tags);
//
        //Set<String> tags = {...event.todo.tags, event.tag};
        //print(tags);
        //final newTodo = event.todo.copyWith(
        //    tags: tags);
        //print(newTodo.tags);
//
        //if(state.userTodoTags.contains(event.tag)){
        //    await _todosRepository.saveTodo(newTodo);
        //    emit(state);
        //}else{
        //    await _todosRepository.saveTodo(newTodo);
        //    emit(
        //        state.copyWith(
        //            userTodoTags: () => state.userTodoTags..toSet().add(event.tag),
        //        ));
        //}
        //print(state.todos.where((todo_i) => todo_i.id == event.todo.id).first.tags);
        Set<String> updatedTags = Set.from(state.todos.singleWhere((t)=> t.id == event.todo.id).tags);
        updatedTags.add(event.tag);

        _todosRepository.saveTodo(event.todo.copyWith(tags: updatedTags));
        //emit(state.copyWith(todos:()=> state.todos));

    }

    Future<void> _removeTagFromTodo(
        TodoRemoveTagEvent event,
        Emitter<TodosOverviewState> emit,
        )async{
        //print(event.todo.tags);
//
        //Set<String> tags = {...event.todo.tags, event.tag};
        //print(tags);
        //final newTodo = event.todo.copyWith(
        //    tags: tags);
        //print(newTodo.tags);
//
        //if(state.userTodoTags.contains(event.tag)){
        //    await _todosRepository.saveTodo(newTodo);
        //    emit(state);
        //}else{
        //    await _todosRepository.saveTodo(newTodo);
        //    emit(
        //        state.copyWith(
        //            userTodoTags: () => state.userTodoTags..toSet().add(event.tag),
        //        ));
        //}
        //print(state.todos.where((todo_i) => todo_i.id == event.todo.id).first.tags);
        Set<String> updatedTags = Set.from(state.todos.singleWhere((t)=> t.id == event.todo.id).tags);
        updatedTags.remove(event.tag);

        _todosRepository.saveTodo(event.todo.copyWith(tags: updatedTags));
        //emit(state.copyWith(todos:()=> state.todos));

    }




    Future<void> _TodoAddSubTodo(
        TodoAddSubTodo event,
        Emitter<TodosOverviewState> emit,
        )async{

        final newTodo = event.parentTodo.copyWith(childIds: event.parentTodo.childIds.toList()..add(event.subTudo.id));
        final newTodo2 = event.subTudo;
        await _todosRepository.saveTodo(newTodo);
        await _todosRepository.saveTodo(newTodo2);
    }

    Future<void> _TodoAddTodo(
        TodoAddTodo event,
        Emitter<TodosOverviewState> emit,
        )async{

        final newTodo = Todo(title: event.todoName, isSubTodo: false, tags: event.tags.toSet());
        //final newTodo2 = event.subTudo;
        await _todosRepository.saveTodo(newTodo);
        //await _todosRepository.saveTodo(newTodo2);
    }

    Future<void> _TodoSetTagFilter(
        TodoSetTagFilter event,
        Emitter<TodosOverviewState> emit,
        )async{
        late Set<String> setTo;
        if(!state.tagFilter.contains(event.tagFilter)) {
            final Set<String> a = {event.tagFilter};
            setTo = {...state.tagFilter, ...a};
        }else{
            Set<String> existing = {...state.tagFilter};
            existing.remove(event.tagFilter);
            setTo = existing;

        }
        emit(state.copyWith(tagFilter: () =>setTo));

    }
}

