import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/Repositories/todos_repository.dart';
import 'package:myfirstflutterproject/l10n/l10n.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/widgets/add_todo_fab.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/widgets/todo_list_tile.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/widgets/todos_overview_filter_button.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/widgets/todos_overview_options_button.dart';

import '../models/todo.dart';


class TodosOverviewPage extends StatelessWidget {
   TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProvider.of<TodosOverviewBloc>(context)..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
    //BlocProvider.of<TodosOverviewBloc>(context).add(const TodosOverviewSubscriptionRequested());
    //return TodosOverviewPage();
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosOverviewAppBarTitle),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
            previous.status != current.status,
            listener: (context, state) {
              if (state.status == TodosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.todosOverviewErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
            previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              final deletedTodo = state.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.todosOverviewTodoDeletedSnackbarText(deletedTodo.title,),
                    ),
                    action: SnackBarAction(
                      label: l10n.todosOverviewUndoDeletionButtonText,
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TodosOverviewBloc>()
                            .add(const TodosOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],

        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TodosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    l10n.todosOverviewEmptyText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: BlocProvider.value(
                value: BlocProvider.of<TodosOverviewBloc>(context),
                child: Stack(
                  children:[
                    ListView(
                    children: [
                      Row(
                        children: [
                          for(final tag in state.userTodoTags)
                            FilterChip(
                              selected: state.tagFilter.contains(tag)? true: false,
                              label:Text(tag),
                              onSelected: (bool)=>{
                              context
                                  .read<TodosOverviewBloc>()
                                  .add(TodoSetTagFilter(tag ))
                              },
                            )
                        ],
                      ),
                      for (final todo in state.filteredTodos )
                       if (state.tagFilteredTodos.contains(todo))
                          if (todo.isSubTodo == false)
                            TodoListTile(
                              isSubTodo: false,
                              todo: todo,
                              onToggleCompleted: (isCompleted) {
                                context
                                    .read<TodosOverviewBloc>()
                                    .add(TodosOverviewTodoCompletionToggled(todo: todo, isCompleted: isCompleted));
                              },
                              onDismissed: (_) {
                                context
                                    .read<TodosOverviewBloc>()
                                    .add(TodosOverviewTodoDeleted(todo));

                              },
                              //onTap: () {
                              //  Navigator.of(context).push(
                              //    EditTodoPage.route(initialTodo: todo),
                              //  );
                              //},
                              //subTodos:myFunc(todo.childIds, context),
                              subTodos:myOtherFunction(todo, context),
                              show: state.showChildren.contains(todo.id),

                           ),
                      ElevatedButton(
                          onPressed: (){
                            context
                                .read<TodosOverviewBloc>()
                                .add(TodoAddTagEvent(state.todos[3], "custom tag"));
                          },
                          child: Text("Test some feature")
                      ),
                      ElevatedButton(
                          onPressed: (){
                            context
                                .read<TodosOverviewBloc>()
                                .add(TodoAddSubTodo( state.todos[3], Todo(title: "my title", isSubTodo: true)));
                          },
                          child: Text("Add subtodo")
                      )
                    ],
                  ),
                    AddTodoFab(),

                  ]
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
List<TodoListTile> myOtherFunction(Todo parent, BuildContext context){
  List<TodoListTile> l = [];
  context.read<TodosOverviewBloc>().getNestedTodos(parent.id).forEach((todo) {
    final t = TodoListTile(
      todo: todo,
      isSubTodo: true,
      show: context.read<TodosOverviewBloc>().state.showChildren.contains(todo.id),
      onToggleCompleted: (isCompleted) {
        context.read<TodosOverviewBloc>()
            .add(TodoSubTodosShow(todo));
      },
      onDismissed: (_) {
        context
            .read<TodosOverviewBloc>()
            .add(TodosOverviewTodoDeleted(todo));
      },

    );
    l.add(t);
  });
  return l;
}



List<TodoListTile> myFunc(List<String> childIds, BuildContext context){
  if (childIds.isEmpty) return [];
  //final todos = context.read<TodosOverviewBloc>().state.todos[5];
  List<Todo> toBeAddedTodos = [];
  final todos = context.read<TodosOverviewBloc>().state.todos;
  todos.forEach( (todo) {
    childIds.forEach((childId) {
      if (todo.childIds.contains(childId)) {
        //toBeAddedTodos.add(todo)
        Iterable<Todo> t = todos.where((todo) => todo.id == childId);
        t.forEach((todo_iterable) => toBeAddedTodos.add(todo_iterable));
      };
    });
  });
  //final subtodos = context.read<TodosOverviewBloc>TodosOverviewBloc().state.todos.contains(element)

  List<TodoListTile> toBeReturned = [];
  toBeAddedTodos.forEach((todo) {
    toBeReturned.add(
    TodoListTile(
      isSubTodo: true,
      todo: todo,
      show: context.read<TodosOverviewBloc>().state.showChildren.contains(todo.id),
      onToggleCompleted: (isCompleted) {
        context.read<TodosOverviewBloc>()
            .add(TodoSubTodosShow(todo));
      },
      onDismissed: (_) {
      context
          .read<TodosOverviewBloc>()
          .add(TodosOverviewTodoDeleted(todo));
      },


  )
  );
  });
  return toBeReturned;
  //return [TodoListTile(
  //    todo: toBeAddedTodos,
  //    onToggleCompleted: (isCompleted) {
  //      //context.read<TodosOverviewBloc>().add(
  //      //  TodosOverviewTodoCompletionToggled(
  //      //    todo: todo,
  //      //    isCompleted: isCompleted,
  //      //  ),
  //      //);
  //      context.read<TodosOverviewBloc>()
  //          .add(TodoSubTodosShow(todo, isCompleted));
  //    },
  //    onDismissed: (_) {
  //      context
  //          .read<TodosOverviewBloc>()
  //          .add(TodosOverviewTodoDeleted(todo));
//
  //    },
  //  ShowSubTodos: (){
  //    context.read<TodosOverviewBloc>()
  //        .add(TodoSubTodosShow(todo, !todo.showSubTodos));
  //  },
  //)];
  //return [context.read<TodosOverviewBloc>().state.todos[5]];
  //return context.read<TodosOverviewBloc>().state.todos.where((todo) => todo.childIds!.contains(todo.id)).toList();
}