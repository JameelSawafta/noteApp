import 'dart:async';
import 'package:noteapp/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper{

  static Database? _db;

  Future<Database> get db async{
    if(_db != null){
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "notes.db");
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }
  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE Notes (
    'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    'title' TEXT NOT NULL,
    'note' TEXT NOT NULL,
    'date' TEXT NOT NULL,
    'color' INTEGER NOT NULL
    )
    ''');

  }

  insertNote(NoteModel noteModel) async {
    var dbClient = await db;
    await dbClient.insert('Notes',noteModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  getAllNotes() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Notes');
    List<NoteModel> noteModel = maps.isNotEmpty
        ? maps.map((e) => NoteModel.fromMap(e)).toList() : [];
    return noteModel;
  }

  getNoteById(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Notes',where: 'id = ?',whereArgs: [id]);
    List<NoteModel> noteModel = maps.isNotEmpty
        ? maps.map((e) => NoteModel.fromMap(e)).toList() : [];
    return noteModel;
  }

  updateData(NoteModel noteModel) async {
    var dbClient = await db;
    await dbClient.update('Notes', noteModel.toMap(), where: 'id = ?', whereArgs: [noteModel.id]);
  }

  deleteData(NoteModel noteModel) async {
    var dbClient = await db;
    await dbClient.delete('Notes', where: 'id = ?', whereArgs: [noteModel.id]);
  }

}