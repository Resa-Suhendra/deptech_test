import 'dart:io';

import 'package:deptech_test/core/model/admin/admin_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseUtils {
  static const _dbName = 'notes_db';
  static const _dbVersion = 1;

  /// Table Admin and Entity
  static const tableAdmin = 'tb_admin';

  static const columnId = '_id';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  static const columnBirthDate = 'birth_date';
  static const columnGender = 'gender';
  static const columnProfileImage = 'profile_image';

  /// Table Notes and Entity
  static const tableNotes = 'tb_notes';

  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnReminder = 'reminder';
  static const columnReminderInterval = 'reminder_interval';
  static const columnAttachment = 'attachment';

  /// make this a singleton class
  LocalDatabaseUtils._privateConstructor();

  static final LocalDatabaseUtils instance =
      LocalDatabaseUtils._privateConstructor();

  /// only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  /// this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  /// SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $tableAdmin ' +
        '($columnId INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        '$columnFirstName TEXT NOT NULL,' +
        '$columnLastName TEXT NOT NULL,' +
        '$columnEmail TEXT NOT NULL,' +
        '$columnPassword TEXT NOT NULL,' +
        '$columnBirthDate TEXT NOT NULL,' +
        '$columnGender TEXT NOT NULL,' +
        '$columnProfileImage TEXT)');

    await db.execute('CREATE TABLE IF NOT EXISTS $tableNotes ' +
        '($columnId INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        '$columnTitle TEXT NOT NULL,' +
        '$columnDescription TEXT NOT NULL,' +
        '$columnReminder TEXT NOT NULL,' +
        '$columnReminderInterval TEXT NOT NULL,' +
        '$columnAttachment TEXT)');
  }

  Future<int> insertDataAdmin(
      Map<String, dynamic> row, String tableName) async {
    Database? db = await instance.database;

    return await db!.insert(
      tableName,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> updateImageAdmin(String base64Image) async {
    Database? db = await instance.database;
    return await db!.rawUpdate(
        'UPDATE $tableAdmin SET $columnProfileImage = ?', [base64Image]);
  }

  Future<int> updateProfileAdmin(AdminModel data) async {
    Database? db = await instance.database;
    return await db!.rawUpdate(
        "UPDATE $tableAdmin SET $columnFirstName = ?, $columnLastName = ?, $columnEmail = ?,$columnPassword = ?,$columnGender = ?, $columnBirthDate = ?",
        [
          data.firstName,
          data.lastName,
          data.email,
          data.password,
          data.gender,
          data.birthDate
        ]);
  }

  Future<int?> queryRowCountAdmin() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tableAdmin'));
  }

  Future<List<Map<String, dynamic>>> loginAdmin(
      String email, String password) async {
    Database? db = await instance.database;

    var result = await db!.query(
      tableAdmin,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> queryAllData(String table) async {
    Database? db = await instance.database;

    var result = await db!.query(
      table,
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> getNotesById(String id) async {
    Database? db = await instance.database;

    var result =
        await db!.query(tableNotes, where: "$columnId = ?", whereArgs: [id]);

    return result;
  }

  Future<int?> deleteNotes(int id) async {
    Database? db = await instance.database;

    return await db!.rawDelete("DELETE FROM $tableNotes WHERE _id = ?", [id]);
  }
}
