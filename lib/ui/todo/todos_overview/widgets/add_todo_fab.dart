import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todos_overview_bloc.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final overviewBloc = BlocProvider.of<TodosOverviewBloc>(context);

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
                value: overviewBloc,
                child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(
                          child: TextField(
                            controller: controller,
                            onSubmitted: (bool) {
                              overviewBloc.add(TodoAddTodo(controller.text, state.newTodoSelectedTags));
                              controller.clear();
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Add subtodo',
                            ),
                          ),
                        ),
                        const Text("Add tags now"),
                        for (final tag in overviewBloc.state.userTodoTags)
                          FilterChip(
                            selected: state.newTodoSelectedTags.contains(tag),
                            label: Text(tag),
                            onSelected: (isSelected) {
                              overviewBloc.add(TodoAddTagToNewTodo(tag));
                            },
                          ),
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
