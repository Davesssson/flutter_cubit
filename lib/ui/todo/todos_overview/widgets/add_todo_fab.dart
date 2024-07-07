import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todos_overview_bloc.dart';

class AddTodoFab extends StatelessWidget {
  const AddTodoFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
        builder: (context, state){
          return BlocProvider.value(
              value: BlocProvider.of<TodosOverviewBloc>(context),
              child: Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(onPressed: ()=>{
                  showModalBottomSheet(
                      constraints: const BoxConstraints(
                        minHeight: 100,
                        minWidth: 100
                      ),
                      context: context,
                      builder: (innerContext) => BlocProvider.value(
                        value: context.read<TodosOverviewBloc>(),
                        child: Column(
                          children: [
                            SizedBox(
                              child: TextField(
                                controller: controller,
                                onSubmitted: (text) => {
                                  context
                                      .read<TodosOverviewBloc>()
                                      .add(TodoAddTodo(text)),
                                  controller.clear()

                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Add subtodo',
                                ),
                              ),
                            ),
                          ],
                        ),

                      ))
                }),
              ),
          );
        }
    );
  }
}
