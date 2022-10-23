import 'package:deptech_test/core/model/notes/notes_model.dart';
import 'package:deptech_test/core/utils/schedule/schedule_utils.dart';
import 'package:deptech_test/core/utils/storage/local_database_utils.dart';
import 'package:deptech_test/injector.dart';
import 'package:flutter/widgets.dart';

class NotesProvider extends ChangeNotifier {

  NotesModel? _notes;
  List<NotesModel> _listNotes = [];

  List<NotesModel> get listNotes => _listNotes;
  NotesModel? get notes => _notes;


  final dbHelper = LocalDatabaseUtils.instance;
  final scheduleUtil = locator<ScheduleUtils>();

  Future<int> createNotes(NotesModel notes) async {
    var res = await dbHelper.insertDataAdmin(
        notes.toJson(), LocalDatabaseUtils.tableNotes);
    scheduleUtil.setSchedule("", 1);
    getAllNotes();
    return res;
  }

  Future<NotesModel?> getNotesById(int id) async {
    var res = await dbHelper.getNotesById(id.toString());

    if (res.isNotEmpty) {
      _notes = NotesModel.fromJson(res[0]);
      notifyListeners();
      return _notes;
    }
  }

  void getAllNotes() async {
    List<Map<String, dynamic>> res =
        await dbHelper.queryAllData(LocalDatabaseUtils.tableNotes);

    if (res.isNotEmpty) {
      _listNotes.clear();
      for (var element in res) {
        _listNotes.add(NotesModel.fromJson(element));
      }

      notifyListeners();
    }
  }

  void deleteNotes(int id) async {
    var res = await dbHelper.deleteNotes(id);
    if (res != null || res! > 0) {
      _listNotes.clear();
      getAllNotes();
      notifyListeners();
    }
  }
}
