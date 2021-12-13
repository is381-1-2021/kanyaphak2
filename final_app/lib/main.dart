import 'package:final_app/models/transac_m.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_app/pages/Add.dart';
import 'package:final_app/pages/dailyTransac.dart';
import 'package:provider/provider.dart';
import 'controllers/transac_c.dart';
import 'models/mood_model.dart';
import 'services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoodModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
  
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      FirebaseAuth auth = FirebaseAuth.instance;

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
      }
    });
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        primaryColor: Color(0xFF8B82D0),
        accentColor: Color(0xFF5F478C),
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
        ),
      ),
      initialRoute: '/2',
      routes: <String, WidgetBuilder> {
        '/1': (context) => TaskEdit(),
        '/2': (context) => AllTask(),
      },
    );
  }
}

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

