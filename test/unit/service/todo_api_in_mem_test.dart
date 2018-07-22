import 'package:test/test.dart';

import 'package:todo/service/todo_api_in_mem.dart';
import 'package:todo/entity/todo.dart';

void main() {

  TodoAPIInMem api;

  setUp(() {
    api = TodoAPIInMem();
  });

  test('.getAll() initially returns an empty list', () async {
    var todos = await api.getAll();
    expect(todos, hasLength(0));
  });

  test('.getAll() returns all the todos', () async {
    api.todos = [
      Todo('0', 'Title1', 'description1', DateTime.now()),
      Todo('1', 'Title2', 'description2', DateTime.now())
    ];
    var todos = await api.getAll();
    expect(todos, hasLength(2));
  });

  test('.getOne() returns the todo with the given id', () async {
    api.todos.add(Todo("0", "First", "Do the homework", DateTime.now()));
    var todo = await api.getOne(id: "0");
    expect(todo.id, equals("0"));
  });

  test('.addOne() adds the given todo to the list', () async {
    var todo = Todo('0', 'First', 'Do the laundry', DateTime.now());
    await api.addOne(entity: todo);
    expect(api.todos, hasLength(1));
  });

  test('.updateOne() updates the todo with the given id', () async {
    var todo = Todo('0', 'First', 'Do the laundry', DateTime.now());
    api.todos = [todo];
    var todoUpdate = Todo('0', 'First updated', "Don't do the laundry", DateTime.now());
    await api.updateOne(entity: todoUpdate);
    expect(api.todos[0].title, equals('First updated'));
  });

  test('.deleteOne() deletes the given todo from the list', () async {
    var todo = Todo('0', 'First', 'Do the laundry', DateTime.now());
    api.todos = [todo];
    await api.deleteOne(id: '0');
    expect(api.todos, hasLength(0));
  });

}