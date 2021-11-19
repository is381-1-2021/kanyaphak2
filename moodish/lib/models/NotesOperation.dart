import 'package:flutter/cupertino.dart';
import 'package:midterm_app/models/Note.dart';

class NotesOperation extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('5 nov 2021', 'ไม่จำเป็นต้องแข่งขัน เพราะเรานั้นไม่ใช่ไก่');
  }

  void addNewNote(String quote, String date) {
    Note note = Note(DateTime.now(), quote);
    _notes.add(note);
    notifyListeners();
  }
}
