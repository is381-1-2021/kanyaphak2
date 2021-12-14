import 'package:flutter/material.dart';
import 'History.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyCalculatorPage(title: 'CALCULATOR'),
      initialRoute: '/2',
      routes: <String, WidgetBuilder>{
        '/1': (context) => const History(title: '',),
        '/2': (context) => const MyCalculatorPage(title: '',),
        },
        
    );
  }
}

class MyCalculatorPage extends StatefulWidget {
  const MyCalculatorPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {

  late String answer;
  late String answerTemp;
  late String inputFull;
  late String operator;
  late bool calculateMode;
  late List inputList;
  late List operationList;
  late List ansList;
  

  @override
  void initState() {
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    inputList=[];
    operationList=[];
    ansList=[];

    calculateMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffecf0f1),
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        elevation: 1,
        actions: [
         IconButton(
           icon: const Icon(Icons.history),
           color: Colors.black,
           onPressed: () {
                Navigator.pushNamed(context, '/1');
              },
         ),
      ],
      ),
      body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[buildAnswerWidget(),
            buildNumPadWidget()
            ],
          )),
    );
  }

  Widget buildAnswerWidget() {
    return Expanded(child: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xffdbdbdb),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(inputFull + " " + operator, style: const TextStyle(fontSize: 18)),
                  Text(answer,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
                ]))));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: const Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("CE", numberButton: false, onTap: () {
                inputList=[];
                operationList=[];
                ansList.insert(0, answer);
                clearAnswer();
              }),
              buildNumberButton("C", numberButton: false, onTap: () {
                inputList=[];
                operationList=[];
                ansList.insert(0, answer);
                clearAll();
              }),
              buildNumberButton("⌫", numberButton: false, onTap: () {
                removeAnswerLast();
              }),
              buildNumberButton("÷", numberButton: false, onTap: () {
                addOperatorToAnswer("÷");
                operationList.add(operator);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
                inputList.add(inputFull);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
                inputList.add(inputFull);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
                inputList.add(inputFull);
              }),
              buildNumberButton("×", numberButton: false, onTap: () {
                addOperatorToAnswer("×");
                operationList.add(operator);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
                inputList.add(inputFull);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
                inputList.add(inputFull);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
                inputList.add(inputFull);
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
                operationList.add(operator);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
                inputList.add(inputFull);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
                inputList.add(inputFull);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
                inputList.add(inputFull);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
                operationList.add(operator);
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("", numberButton: false, onTap: () {}),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
                inputList.add(inputFull);
              }),
              buildNumberButton(".", numberButton: false, onTap: () {
                addDotToAnswer();
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
            ]),
          ],
        ));
  }

  void toggleNegative() {
    setState(() {
      if (answer.contains("-")) {
        answer = answer.replaceAll("-", "");
      } else {
        answer = "-" + answer;
      }
    });
  }

  void clearAnswer() {
    setState(() {
      answer = "0";
    });
  }

  void clearAll() {
    setState(() {
      answer = "0";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }


  void calculate() {
    setState(() {
      if (calculateMode) {
        bool decimalMode = false;
        double value = 0;
        if (answer.contains(".") || answerTemp.contains(".")) {
          decimalMode = true;
        }

        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "×") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "÷") {
          value = (double.parse(answerTemp) / double.parse(answer));
        }

        if (!decimalMode) {
          answer = value.toInt().toString();
        } else {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";
      }
    });
  }

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = "0";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          inputFull = "";
          operator = "";
        } else {
          operator = op;
        }
      }
    });
  }

  void addDotToAnswer() {
    setState(() {
      if (!answer.contains(".")) {
        answer = answer + ".";
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      }
      else if (number != 0 && answer == "0") {
        answer = number.toString();
      }
      else {
        answer += number.toString();
      }
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && (answer == "." || answer == "-")) {
            answer = "0";
          }
        } else {
          answer = "0";
        }
      });
    }
  }

  Widget buildNumberButton(String str, { @required Function()?onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = Container(
          margin: const EdgeInsets.all(1),
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap, splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold)))))));
    } else {
      widget = Container(
          margin: EdgeInsets.all(1),
          child: Material(
              color: Color(0xffecf0f1),
              child: InkWell(onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 28)))))));
    }

    return Expanded(child: widget);
  }
}