import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/models/todo.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
    this.subTodos = const [],
    required this.show,
    required this.isSubTodo
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;
  final List<TodoListTile> subTodos;
  final bool show;
  final bool isSubTodo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;
    final controller = TextEditingController();

    return Dismissible(
      key: Key('todoListTile_dismissible_${todo.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            title: Text(
              todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: !todo.isCompleted
                  ? null
                  : TextStyle(
                color: captionColor,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text(
              todo.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Checkbox(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              value: todo.isCompleted,
              onChanged: onToggleCompleted == null
                  ? null
                  : (value) => onToggleCompleted!(value!),
            ),
            trailing:  this.isSubTodo ? null: ElevatedButton(
                //onPressed: ShowSubTodosFunction,
                onPressed: (){
                  context.read<TodosOverviewBloc>().add(TodoSubTodosShow(todo));
                },
                child: Icon(Icons.arrow_right)
            )
          ),
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               ...generateTags(todo, context)
             ],
           ),


           if (show == true)
             if (!isSubTodo)
                Padding(
                 padding:  EdgeInsets.fromLTRB(60.0, 0,0,0),
                 child:  SizedBox(
                   child: TextField(
                     controller: controller,
                     onSubmitted: (text) => {
                     context
                         .read<TodosOverviewBloc>()
                         .add(TodoAddSubTodo( todo, Todo(title: text, isSubTodo: true))),
                       controller.clear()
                       
                     },
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Add subtodo',
                     ),
                   ),
                 ),
               ),
          if (show == true)
            for (final todo in subTodos)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 0,0,0),
                    child: todo,
                  )
        ],
      ),
    );
  }
}

List<Widget> generateTags(Todo todo, BuildContext context){
  TextEditingController controller = TextEditingController();
  List<Widget> tagsToReturn = [];

 ElevatedButton b = ElevatedButton(
     onPressed: (){
       Scaffold.of(context).showBottomSheet(
       (BuildContext context) {
           return Container(
             height: (MediaQuery.of(context).size.height /4)*3,
             color: Colors.white38,
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 mainAxisSize: MainAxisSize.max,
                 children: [
                   IconButton(
                     icon: const Icon(Icons.close),
                     onPressed: () {
                       Navigator.pop(context);
                     },
                   ),
                   TextField(
                     controller: controller,
                     onSubmitted: (text) => {
                     context
                         .read<TodosOverviewBloc>()
                         .add(TodoAddTagEvent(todo, text)),
                     Navigator.pop(context)
                     },
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Add tag',
                     ),
                   ),

                   for (final tag in todo.tags)
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(tag),
                            IconButton(
                             icon: const Icon(Icons.close),
                             onPressed: () {
                                 print("asd");
                             },
                           )

                         ],
                       ),
                     ),
                   for (final tag in context.read<TodosOverviewBloc>().state.userTodoTags)
                     if (!todo.tags.contains(tag))
                       ElevatedButton(
                           onPressed: (){
                             context
                                 .read<TodosOverviewBloc>()
                                 .add(TodoAddTagEvent(todo, tag));
                           },
                           child: Text(tag))


                 ],
               ),
             ),
           );
         },
       );
     },
     child: const Text('asd')
     
 );

  tagsToReturn.add(b);
  if (todo.tags.isEmpty) return tagsToReturn;
  for (final tag in todo.tags) {
    tagsToReturn.add(
      Transform(
        transform: Matrix4.identity()..scale(0.6),
        child: Chip(
          label: Text(
            tag,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFa3bdc4),
        ),
      ),
    );
  }
  return tagsToReturn;
}