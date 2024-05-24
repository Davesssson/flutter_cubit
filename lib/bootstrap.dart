


import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstflutterproject/Repositories/todos_api.dart';
import 'package:myfirstflutterproject/Repositories/todos_repository.dart';
import 'package:myfirstflutterproject/app/app.dart';
import 'package:myfirstflutterproject/app/app_bloc_observer.dart';

void bootstrap({required TodosApi todosApi}){
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();
  final todosRepository = TodosRepository(todosApi: todosApi);
  runZonedGuarded(

      () => runApp(App(todosRepository: todosRepository)),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}