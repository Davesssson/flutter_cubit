import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/Repositories/todos_repository.dart';
import 'package:myfirstflutterproject/ui/dashboard/dashboard.dart';
import 'package:bloc/bloc.dart';
import 'package:myfirstflutterproject/ui/todo/todos_overview/bloc/todos_overview_bloc.dart';
import '../l10n/app_localizations.dart';




class App extends StatelessWidget{

  const App({required this.todosRepository, super.key});
  final TodosRepository todosRepository ;

  @override
  Widget build(BuildContext context) {
      return RepositoryProvider.value(
          value: todosRepository,
          child:  AppView(tr: todosRepository ,),
      );
  }
}

class AppView extends StatelessWidget{
  const AppView({super.key, required this.tr});
  final TodosRepository tr;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates ,
      supportedLocales: AppLocalizations.supportedLocales,
      home:  MultiBlocProvider(
        providers: [
          BlocProvider<TodosOverviewBloc>(
            create: (context) => TodosOverviewBloc(todosRepository: tr)
          ),
        ],
        child: DashboardPage()
      ),
    );

  }
}