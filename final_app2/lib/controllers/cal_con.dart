import 'dart:async';

import 'package:midterm_app/models/cal_mo.dart';
import 'package:midterm_app/services/cal_ser.dart';

class TaskController {
  final Services services;
  List<Task> tasks = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TaskController(this.services);

  Future<List<Task>> fetchTasks() async {
    onSyncController.add(true);
    tasks = await services.getTasks();
    onSyncController.add(false);

    return tasks;
  }
}
