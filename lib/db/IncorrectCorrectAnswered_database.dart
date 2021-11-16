/**
 * Created by Malte Denecke
 */


import 'package:classroomquiz_usersedition/model/IncorrectCorrectAnswered.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';




class IncorrectCorrectAnsweredDatabase {
  static final IncorrectCorrectAnsweredDatabase instance = IncorrectCorrectAnsweredDatabase._init();

  static Database? _database;

  IncorrectCorrectAnsweredDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('incorrectCorrectAnswered.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';


    await db.execute('''
CREATE TABLE $incorrectCorrectAnsweredpack ( 
  ${IncorrectCorrectAnsweredfield.id} $idType, 
  ${IncorrectCorrectAnsweredfield.questiontext} $textType,
   ${IncorrectCorrectAnsweredfield.iscorrect} $textType,
    ${IncorrectCorrectAnsweredfield.gamename} $textType,
    ${IncorrectCorrectAnsweredfield.gamecounter} $integerType)
''');
  }

  Future<IncorrectCorrectAnswered> create(IncorrectCorrectAnswered incorrectCorrectAnswered) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(incorrectCorrectAnsweredpack, incorrectCorrectAnswered.toJson());
    return incorrectCorrectAnswered.copy(id: id);
  }
  Future<void> createByString(String incorrectCorrectAnswered) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    final id = await db
        .rawInsert('INSERT INTO incorrectCorrectAnswered VALUES ($incorrectCorrectAnswered)');

  }
  Future<IncorrectCorrectAnswered> readIncorrectCorrectAnsweredbyId(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      incorrectCorrectAnsweredpack,
      columns: IncorrectCorrectAnsweredfield.values,
      where: '${IncorrectCorrectAnsweredfield.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return IncorrectCorrectAnswered.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }



  Future<List<IncorrectCorrectAnswered>> readAllIncorrectCorrectAnswered() async {
    final db = await instance.database;


    //OrderByID
    final orderBy = '${IncorrectCorrectAnsweredfield.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(incorrectCorrectAnsweredpack, orderBy: orderBy);

    // print(result);

    return result.map((json) => IncorrectCorrectAnswered.fromJson(json)).toList();
  }

  Future<int> update(IncorrectCorrectAnswered incorrectCorrectAnswered) async {
    final db = await instance.database;

    return db.update(
      incorrectCorrectAnsweredpack,
      incorrectCorrectAnswered.toJson(),
      where: '${IncorrectCorrectAnsweredfield.id} = ?',
      whereArgs: [incorrectCorrectAnswered.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      incorrectCorrectAnsweredpack,
      where: '${IncorrectCorrectAnsweredfield.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete2(String gamename) async {
    final db = await instance.database;

    return await db.delete(
        incorrectCorrectAnsweredpack,
        where: '${IncorrectCorrectAnsweredfield.gamename} = ?',
        whereArgs: [gamename]
    );
  }
  Future deleteTable()async{
    final db = await instance.database;
    return
      await db.rawInsert('DELETE FROM incorrectCorrectAnswered');
  }
  Future dropTable()async{
    final db = await instance.database;
    return
      await db.rawInsert('DROP DATABASE incorrectCorrectAnswered.db;');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
