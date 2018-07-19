import 'package:flutter/material.dart';
import 'package:todo/entity/todo.dart';
import 'package:todo/service/todo_api.dart';
import 'package:todo/service/todo_api_in_mem.dart';

TodoAPIInMem api = TodoAPIInMem();

void main() {
  api.todos = [
    Todo('0', 'Title1', 'description1', DateTime.now()),
    Todo('1', 'Title2', 'description2', DateTime.now())
  ];
  runApp(new MaterialApp(
    title: 'Todo',
    home: TodoList(api),
  ));
} 

class TodoList extends StatefulWidget {
  TodoAPI api;

  TodoList(this.api);

  @override
  _TodoListState createState() => _TodoListState(api);
}

class _TodoListState extends State<TodoList> {
  TodoAPI api;
  List<Todo> todos = [];

  _TodoListState(this.api);

  @override
  void initState() {
    api.getAll().then((res) {
      setState(() {
        todos = res;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          Container(
            child: FlatButton(
              child: Text(
                "+", style: 
                TextStyle(
                  fontSize: 20.0, 
                  fontWeight: FontWeight.bold, 
                  color: Color.fromARGB(255, 255, 255, 255)
                )
              ),
              onPressed: () {
                //Navigator.of(context).push()
              },
              shape: CircleBorder(),
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ]
      ),
      body: ListView(
        children: _buildTodoItems(),
      ),
    );
  }

  List<_TodoItem> _buildTodoItems() {
    return todos.map((todo) => new _TodoItem(todo)).toList();
  }

}

class _TodoItem extends ListTile {

  _TodoItem(Todo todo) :
    super(
      title: Text(todo.title),
      subtitle: Text(todo.description),
    );

}