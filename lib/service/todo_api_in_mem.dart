import 'todo_api.dart';
import 'dart:async';

import 'package:todo/entity/todo.dart';

class TodoAPIInMem implements TodoAPI {

  List<Todo> todos = [];

  addOne({Todo entity}) {
    todos.add(entity);
    return Future.value();
  }

  getAll() {
    return Future.value(todos);
  }

  getOne({String id}) {
    return Future.value(todos.where((todo) => todo.id == id).first);
  }

  updateOne({String id, Todo entity}) {
    var index = todos.indexWhere((todo) => todo.id == id);
    todos[index] = entity;
    return Future.value();
  }

  deleteOne({String id}) {
    todos.removeWhere((todo) => todo.id == id);
    return Future.value();
  }

}