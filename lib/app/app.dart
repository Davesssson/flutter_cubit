import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstflutterproject/Repositories/todos_repository.dart';
import 'package:myfirstflutterproject/ui/dashboard/dashboard.dart';

import '../l10n/app_localizations.dart';




class App extends StatelessWidget{

  const App({required this.todosRepository, super.key});
  final TodosRepository todosRepository ;

  @override
  Widget build(BuildContext context) {
      return RepositoryProvider.value(
          value: todosRepository,
          child: const AppView(),
      );
  }
}

class AppView extends StatelessWidget{
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates ,
      supportedLocales: AppLocalizations.supportedLocales,
      home:  DashboardPage(),
    );

  }
}