

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstflutterproject/Services/local_storage_todos_api.dart';
import 'package:myfirstflutterproject/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance()
  );

  bootstrap(todosApi: todosApi);
}