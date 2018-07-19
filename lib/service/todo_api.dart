import 'api.dart';
import 'package:todo/entity/todo.dart';

abstract class TodoAPI implements API<Todo> {

  addOne({Todo entity});

  getAll();

  getOne({String id});

  updateOne({String id, Todo entity});

  deleteOne({String id});

}