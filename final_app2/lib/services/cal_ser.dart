import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:midterm_app/models/cal_mo.dart';

abstract class Services {
  Future<List<Task>> getTasks();
}

class FirebaseServices extends Services {
  @override

  Future<List<Task>> getTasks() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('mink_final2').get();

    var all = AllTasks.fromSnapshot(snapshot);

    return all.tasks;
  }

}
