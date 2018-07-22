import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo/entity/todo.dart';

class TodoDetails extends StatefulWidget {
  Todo todo;

  TodoDetails(this.todo);

  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {

  var _due = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final _formatter = DateFormat('yyyy-MM-dd');
  final _titleEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      _due = widget.todo.due;
      _titleEditingController.text = widget.todo.title;
      _descriptionEditingController.text = widget.todo.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = MediaQuery.of(context).size.width * 0.05;
    final nonEmptyValidator = (value) {
      if (value.isEmpty) {
        return "This field can't be empty";
      }
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          Container(
            child: FlatButton(
              child: Text(
                "Save", style: 
                TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                final title = _titleEditingController.text;
                final description = _descriptionEditingController.text;

                var todoToReturn = Todo('', title, description, _due);
                if (widget.todo != null) {
                  todoToReturn.id = widget.todo.id;
                }
                Navigator.pop(context, todoToReturn);
              },
            ),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
      body: Card(
        margin: EdgeInsets.all(gap),
        color: Colors.blueGrey,
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(gap),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Title'),
                  TextFormField(
                    validator: nonEmptyValidator, 
                    controller: _titleEditingController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: gap),
                    child: Text('Description'),
                  ),
                  TextFormField(
                    validator: nonEmptyValidator,
                    controller: _descriptionEditingController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: gap),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * .1,
                      child: RaisedButton(
                        onPressed: () async {
                          var now = DateTime.now();
                          final date = await showDatePicker(
                            context: context,
                            firstDate: now.isBefore(_due) ? now : _due,
                            lastDate: DateTime(3000),
                            initialDate: _due,
                          );
                          setState(() {
                            if (date != null) {
                              _due = date;
                            }
                          });
                        },
                        color: Colors.grey,
                        child: Text("Due: ${_formatter.format(_due)}"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ), 
      ),
    );
  }
}
