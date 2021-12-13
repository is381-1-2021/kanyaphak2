import 'dart:async';

import 'package:final_app/models/transac_m.dart';
import 'package:final_app/services/services.dart';

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
