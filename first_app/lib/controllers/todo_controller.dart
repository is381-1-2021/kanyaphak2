import 'dart:async';

import 'package:first_app/models/todo_model.dart';
import 'package:first_app/services/services.dart';

class TodoController {
  final HttpServices services;
  List<Todo> todos = List.empty();

  StreamController<bool> onSynceController = StreamController();
  Stream<bool> get onSync => onSynceController.stream;

  TodoController(this.services);

  Future<List<Todo>> fetchTodos() async {
    onSynceController.add(true);
    todos = await services.getTodos();
    onSynceController.add(false);

    return todos;
  }
}
