// ignore: file_names
import 'package:flutter/material.dart';
import 'package:midterm_app/services/cal_ser.dart';
import 'package:midterm_app/models/cal_mo.dart';
import 'package:midterm_app/controllers/cal_con.dart';




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const History(title: 'Calculator'),
      
    );
  }
}

class History extends StatefulWidget {
  const History({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
                          icon: Icon(Icons.history, size: 30,),
                          alignment: Alignment.centerLeft,
                          onPressed: (){},
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                          '${tasks[index].his}',
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
                          '= ${tasks[index].ans}',
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
        ),
        body: Align(
          alignment: Alignment.centerLeft,
          child: body
          ),
        );
  }
}

