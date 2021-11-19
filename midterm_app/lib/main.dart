import 'package:flutter/material.dart';
import 'pages/TaskOverview.dart';
import 'pages/TaskEdit.dart';
import 'pages/daily_activities.dart';
import 'pages/habit_tracker.dart';
import 'pages/mood_tracker.dart';
import 'pages/moodish_goods.dart';
import 'pages/login.dart';
import 'pages/food_calories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xFF8B82D0),
          accentColor: Color(0xFF5F478C),
          fontFamily: 'Montserrat',
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xffFFC392),
          )),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      //initialRoute: '/1',
      routes: <String, WidgetBuilder>{
        '/1': (context) => TaskOverview(),
        '/2': (context) => moodish_goods(),
        '/3': (context) => daily_activities(),
        '/4': (context) => habit_tracker(),
        '/5': (context) => mood_tracker(),
        '/6': (context) => TaskEdit(),
        '/7': (context) => login(),
        '/7': (context) => food_calories(),
      },
    );
  }
}

class Mypage extends StatefulWidget {
  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> pagename = <String>[
    'TO DO LIST',
    'MOODISH GOODS',
    'DAILY ACTIVITIES',
    'HABIT TRACKER',
    'MOOD TRACKER',
    'FOOD CALORIES'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOODISH HOMPAGE'),
        actions: [
          IconButton(
            icon: Icon(Icons.manage_accounts_sharp),
            tooltip: 'Button1',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/${index + 1}');
            },
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://www.vhv.rs/dpng/d/428-4284306_transparent-moon-emoji-pink-moon-face-emoji-hd.png'),
                ),
              ),
              child: Center(
                child: Text(
                  pagename[index],
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
