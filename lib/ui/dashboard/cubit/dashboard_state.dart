part of 'dashboard_cubit.dart';

enum DashboardTab {todos, weights }

final class DashboardState extends Equatable{
  const DashboardState({
    this.tab = DashboardTab.todos
  });

  final DashboardTab tab;

  @override
  List<Object> get props => [tab];
}