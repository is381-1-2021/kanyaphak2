import 'package:flutter/material.dart';
import 'package:midterm_app/controllers/task_controller.dart';
import 'package:midterm_app/models/Task.dart';
import 'package:provider/provider.dart';
import 'package:midterm_app/models/TaskOperation.dart';
import 'TaskEdit.dart';
import 'package:midterm_app/services/services.dart';

// class TodoList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TodoModel>(
//         builder: (context, todoModel, child) => ListView.builder(
//             padding: const EdgeInsets.all(10.0),
//             itemCount: todoModel.todos.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.all(2.0),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFFFD376),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   height: 150,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.assignment_outlined, size: 30,),
//                           onPressed: () {},
//                         ),
//                         Text(
//                           '${todoModel.todos[index].title}',
//                           style: TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ]
//                     ),
//                   ),
//               );
//               }
//             )
//           );
//   }
// }

class AllTask extends StatefulWidget {
  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  List<Task> tasks = List.empty();
  bool isLoading = false;
  var services = FirebaseServices();
  var controller;
  void initState() {
    super.initState();
    controller = TaskController(services);

    controller.onSync.listen(
      (bool syncState) => setState(() => isLoading = syncState),
    );
  }

  void _getTasks() async {
    var newTasks = await controller.fetchTasks();

    setState(() => tasks = newTasks);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: tasks.isEmpty ? 1 : tasks.length,
          itemBuilder: (ctx, index) {
            if (tasks.isEmpty) {
              return Text('Tap button to fetch tasks');
            }
            return Padding(
              //title: Text(tasks[index].headline),
              //subtitle: Text(tasks[index].detail),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFD376),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  //height: 150,
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.assignment_outlined, size: 30,),
                          alignment: Alignment.centerLeft,
                          onPressed: (){},
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                          'DUEDATE : ${tasks[index].duedate.toString().substring(0, tasks[index].duedate.toString().lastIndexOf(' '))}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                            Text(
                          '${tasks[index].headline}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.lightBlue[700]!,
                          ),
                        ),
                        Text(
                          '${tasks[index].detail}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                          ],
                        ),
                      ]
                    ),
                  ),
            );
          },
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: _getTasks,
          child: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        appBar: AppBar(
          title: Text('To do list'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/4');
              },
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.centerLeft,
          child: body
          ),
        );
  }
}

