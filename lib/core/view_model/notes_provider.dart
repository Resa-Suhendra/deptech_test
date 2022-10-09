import 'package:deptech_test/core/model/notes_model.dart';
import 'package:flutter/widgets.dart';

class NotesProvider extends ChangeNotifier {
  List<NotesModel> _listNotes = [];

  List<NotesModel> get listNotes => _listNotes;

  void queryListNotes() {

  }



}