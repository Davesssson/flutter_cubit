import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/ui/todo/add_new_todo_bottom_sheet/bloc/add_new_todo_bloc.dart';
import 'package:myfirstflutterproject/ui/todo/add_new_todo_bottom_sheet/bloc/add_new_todo_event.dart';
import 'package:myfirstflutterproject/ui/todo/add_new_todo_bottom_sheet/bloc/add_new_todo_state.dart';
import '../bloc/todos_overview_bloc.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final overviewBloc = BlocProvider.of<TodosOverviewBloc>(context);
    final addNewTodoBloc = BlocProvider.of<AddNewTodoBloc>(context);

    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        child: Icon(Icons.abc),
        onPressed: () {
          showModalBottomSheet(
            constraints: const BoxConstraints(
              minHeight: 100,
              minWidth: 100,
            ),
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: addNewTodoBloc,
                child: BlocBuilder<AddNewTodoBloc, AddNewTodoState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(
                          child: TextField(
                            controller: controller,
                            onSubmitted: (text) {
                              context
                                  .read<TodosOverviewBloc>()
                                  .add(TodoAddTodo(text));
                              controller.clear();
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Add subtodo',
                            ),
                          ),
                        ),
                        const Text("Add tags now"),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AddNewTodoBloc>()
                                .add(const TodoAddNewTodoTag("asdasd"));
                          },
                          child: Text("asd"),
                        ),
                        for (final tag in overviewBloc.state.userTodoTags)
                          FilterChip(
                            selected: state.selectedTags.contains(tag),
                            label: Text(tag),
                            onSelected: (isSelected) {
                              context
                                  .read<AddNewTodoBloc>()
                                  .add(TodoAddNewTodoTag(tag));
                            },
                          ),
                        for (final tag in state.selectedTags) Text(tag),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
