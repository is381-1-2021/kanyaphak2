import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/models/transac_m.dart';

abstract class Services {
  Future<List<Task>> getTasks();
}

class FirebaseServices extends Services {
  @override
  Future<List<Task>> getTasks() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('moodish_task').get();

    var all = AllTasks.fromSnapshot(snapshot);

    return all.tasks;
  }
}
