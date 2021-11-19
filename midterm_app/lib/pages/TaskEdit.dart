import 'package:flutter/material.dart';

class TaskEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Edit'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String _task = '';
  String _info = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.assignment),
                hintText: 'input task headline',
                labelText: 'TASK'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter task.';
              }
            },
            onSaved: (value) {
              _task = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'input task detail',
                labelText: 'DETAIL'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter task detail.';
              }
            },
            onSaved: (value) {
              _info = value!;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('TASK ADDING SUCCEED!'),
                ));

                var response = '$_task \n\n DETAIL : \n$_info ';
                //var response = <String>['$_task', '$_info'];

                Navigator.pop(context, response);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
