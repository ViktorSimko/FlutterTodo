import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:todo/entity/todo.dart';
import 'package:todo/service/todo_api.dart';
import 'package:todo/widget/todo_list.dart';

class MockTodoAPI extends Mock implements TodoAPI {}

void main() {
  testWidgets('all the todos should be shown initially', (WidgetTester tester) async {

    var mockAPI = MockTodoAPI();

    var todos = [
      Todo('0', 'Title1', 'description1', DateTime.now()),
      Todo('1', 'Title2', 'description2', DateTime.now())
    ];

    var todosFuture = Future.value(todos);

    when(mockAPI.getAll()).thenReturn(todosFuture);

    var testTodoList = Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(),
        child: TodoList(mockAPI),
      ),
    );
    await tester.pumpWidget(testTodoList);
    await tester.pump();

    expect(find.text(todos[0].title), findsOneWidget);
    expect(find.text(todos[1].title), findsOneWidget);
  });
}
