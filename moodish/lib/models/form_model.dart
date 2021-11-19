import 'package:flutter/material.dart';

class FormModel extends ChangeNotifier {
  String? _Email;
  String? _Password;

  get Email => this._Email;

  set Email(value) {
    this._Email = value;
    notifyListeners();
  }

  get Password => this._Password;

  set Password(value) {
    this._Password = value;
    notifyListeners();
  }
}
