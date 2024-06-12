

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/ui/dashboard/dashboard.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/view/todos_overview_page.dart';


class DashboardPage extends StatelessWidget{
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => DashboardCubit(),
        child: const DashboardView(),
      );
  }
}
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((DashboardCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedTab.index,
            onDestinationSelected: (int index) {
              List<DashboardTab> values = DashboardTab.values.map((e) => e).toList();
              context.read<DashboardCubit>().setTab(values[index]);
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Todos'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: selectedTab.index,
              children: const [Text("asd"),  TodosOverviewPage()],
            ),
          ),
        ],
      ),
    );
  }
}


// Other implementation
/*class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((DashboardCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [Text("elso"), Text("masodik")]
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            _DashboardTabButton(
              groupValue: selectedTab,
              value: DashboardTab.todos,
              icon:const Icon(Icons.abc)
            ),
            _DashboardTabButton(
                groupValue: selectedTab,
                value: DashboardTab.weights,
                icon:const Icon(Icons.abc)
            )
          ],
        ),
      )
    );
  }
}*/


class _DashboardTabButton extends StatelessWidget{
  const _DashboardTabButton({
    required this.groupValue,
    required this.value,
    required this.icon
  });

  final DashboardTab groupValue;
  final DashboardTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: ()=> context.read<DashboardCubit>().setTab(value),
        icon: icon,
    );

  }
}