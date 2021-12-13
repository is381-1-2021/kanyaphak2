import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:midterm_app/models/mood_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TodoEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Edit"),
        ),
        body: TaskEdit());
  }
}

class TaskEdit extends StatefulWidget {
  @override
  _TaskEditState createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController headline = new TextEditingController();
  TextEditingController detail = new TextEditingController();
  
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //String? _duedate;

  @override
  Widget build(BuildContext context) {
    //_duedate = DateFormat("dd-MM-yyyy").format(_focusedDay);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.assignment),
              hintText: 'Input task headline',
              labelText: 'TASK',
            ),
            controller: headline,
            validator: (headline) {
              if (headline == null || headline.isEmpty) {
                return 'Please enter task';
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.info),
              hintText: 'Input task detail',
              labelText: 'DETAIL',
            ),
            controller: detail,
            validator: (detail) {
              if (detail == null || detail.isEmpty) {
                return 'Please enter task';
              }
            },
          ),
          SizedBox(height: 15.0),
          //calendar
          Text(
            'SELECT DUE DATE',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              //backgroundColor: Colors.blue[100],
              foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.indigo[200]!,
                    ),
              ),
          Container(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          //Container(
          //  padding: EdgeInsets.all(20),
          //  height: 30,
          //  width: 350,
          //  color: Color(0xFF8B82D0),
          //  child: Consumer<MoodModel>(
          //    builder: (context, model, child) {
          //      return Text(
          //        '$_focusedDay',
          //        style: TextStyle(color: Colors.white, fontSize: 18),
          //      );
          //    },
          //  ),
          //),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Map<String, dynamic> data = {
                  "headline": headline.text,
                  "detail": detail.text,
                  "duedate" :_focusedDay,
                };
                FirebaseFirestore.instance.collection("moodish_task").add(data);

                Navigator.pop(context);
              }
            },
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF5F478C),
              fixedSize: Size(250, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
    
  }
}
