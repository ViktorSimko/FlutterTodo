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
    List<Todo> todosToReturn = [];
    for (final todo in todos) {
      todosToReturn.add(Todo(todo.id, todo.title, todo.description, todo.due));
    }

    return Future.value(todosToReturn);
  }

  getOne({String id}) {
    final todosMatching = todos.where((todo) => todo.id == id);
    if (todosMatching.length == 0) {
      return Future.value(null);
    }
    final todo = todosMatching.first;
    final todoToReturn = Todo(todo.id, todo.title, todo.description, todo.due);
    return Future.value(todoToReturn);
  }

  updateOne({Todo entity}) {
    var index = todos.indexWhere((todo) => todo.id == entity.id);
    todos[index] = entity;
    return Future.value();
  }

  deleteOne({String id}) {
    todos.removeWhere((todo) => todo.id == id);
    return Future.value();
  }

}