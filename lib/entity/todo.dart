import 'entity.dart';

class Todo implements Entity {
  String id;
  String title;
  String description;
  DateTime due;

  Todo(this.id, this.title, this.description, this.due);
}