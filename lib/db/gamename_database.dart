/**
 * Created by Malte Denecke
 */
import 'package:classroomquiz_usersedition/model/gamename.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';




class GamenameDatabase {
  static final GamenameDatabase instance = GamenameDatabase._init();

  static Database? _database;

  GamenameDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('gamename.db');
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
CREATE TABLE $gamenamepack ( 
  ${Gamenamefield.id} $idType, 
  ${Gamenamefield.gamename} $textType

)
''');
  }

  Future<Gamename> create(Gamename gamename) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(gamenamepack, gamename.toJson());
    return gamename.copy(id: id);
  }
  Future<void> createByString(String gamename) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
     final id = await db
         .rawInsert('INSERT INTO gamename VALUES ($gamename)');

  }
  Future<Gamename> readGamenamebyId(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      gamenamepack,
      columns: Gamenamefield.values,
      where: '${Gamenamefield.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Gamename.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }



  Future<List<Gamename>> readAllGamenames() async {
    final db = await instance.database;


    //OrderByID
    final orderBy = '${Gamenamefield.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(gamenamepack, orderBy: orderBy);

    // print(result);

    return result.map((json) => Gamename.fromJson(json)).toList();
  }

  Future<int> update(Gamename gamename) async {
    final db = await instance.database;

    return db.update(
      gamenamepack,
      gamename.toJson(),
      where: '${Gamenamefield.id} = ?',
      whereArgs: [gamename.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      gamenamepack,
      where: '${Gamenamefield.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete2(String gamename) async {
    final db = await instance.database;

    return await db.delete(
        gamenamepack,
        where: '${Gamenamefield.gamename} = ?',
        whereArgs: [gamename]
    );
  }
  Future deleteTable()async{
    final db = await instance.database;
    return
      await db.rawInsert('DELETE FROM gamename');
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
