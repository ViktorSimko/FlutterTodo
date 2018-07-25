import 'package:flutter/material.dart';

import 'package:todo/entity/todo.dart';
import 'package:todo/service/todo_api.dart';
import 'package:todo/widget/todo_details.dart';

class TodoList extends StatefulWidget {
  TodoAPI api;

  TodoList(this.api);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> _todos = [];

  Widget _getListItem(Todo todo) {
    final gap = MediaQuery.of(context).size.width * .05;

    return Card(
      color: Colors.blueGrey,
      margin: EdgeInsets.symmetric(horizontal: gap, vertical: gap / 2),
      child: ListTile(title: Text(todo.title)),
    );
  }

  ListView _getList(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return Dismissible(
          key: Key(todo.id),
          onDismissed: (direction) async {
            await widget.api.deleteOne(id: todo.id);
            todos.removeWhere((t) => t.id == todo.id);
            Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text("${todo.title} removed")));
          },
          direction: DismissDirection.endToStart,
          background: Container(color: Colors.red),
          child: GestureDetector(
            child: _getListItem(todo),
            onTap: () async {
              final Todo updatedTodo = await Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => TodoDetails(todo)),
              );

              if (updatedTodo == null) {
                return;
              }

              await widget.api.updateOne(entity: updatedTodo);
              final i = _todos.indexWhere((t) => t.id == updatedTodo.id);
              if (i == -1) {
                return;
              }

              _todos[i] = updatedTodo; 
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * .05;

    final listFutureBuilder = FutureBuilder(
      future: widget.api.getAll(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState)  {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            _todos = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(top: gap / 2),
              child: _getList(_todos),
            );
          default:
        }
      },
    );

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
                ),
              ),
              onPressed: () async {
                final Todo todo = await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => TodoDetails(null)),
                );

                if (todo == null) {
                  return;
                }

                await widget.api.addOne(entity: todo);
                _todos.add(todo);
              },
              shape: CircleBorder(),
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
      body: listFutureBuilder,
    );
  }
}