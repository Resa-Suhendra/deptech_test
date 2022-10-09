import 'package:deptech_test/core/model/notes_model.dart';
import 'package:deptech_test/core/utils/storage/local_database_utils.dart';
import 'package:flutter/widgets.dart';

class NotesProvider extends ChangeNotifier {
  List<NotesModel> _listNotes = [];

  List<NotesModel> get listNotes => _listNotes;

  final dbHelper = LocalDatabaseUtils.instance;

  Future<int> createNotes(NotesModel notes) async {
    var res = await dbHelper.insertDataAdmin(
        notes.toJson(), LocalDatabaseUtils.tableNotes);

    return res;
  }

  void getAllNotes() async {
    List<Map<String, dynamic>> res =
        await dbHelper.queryAdminData(LocalDatabaseUtils.tableAdmin);

    if (res.isNotEmpty) {
      _listNotes.clear();
      for (var element in res) {
        _listNotes.add(NotesModel.fromJson(element));
      }
    }

    notifyListeners();
  }
}
