import 'package:flutter/material.dart';

import 'package:todo/entity/todo.dart';
import 'package:todo/service/todo_api_in_mem.dart';
import 'package:todo/widget/todo_list.dart';

TodoAPIInMem api = TodoAPIInMem();

void main() {
  api.todos = [
    Todo('0', 'Title1', 'description1', DateTime.now()),
    Todo('1', 'Title2', 'description2', DateTime.now())
  ];
  runApp(new MaterialApp(
    title: 'Todo',
    home: TodoList(api),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      accentColor: Colors.cyanAccent,
    ),
  ));
} 

