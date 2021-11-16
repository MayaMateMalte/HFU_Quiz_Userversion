/**
 * Created by Malte Denecke
 */

import 'package:classroomquiz_usersedition/model/username.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';




class UsernameDatabase {
  static final UsernameDatabase instance = UsernameDatabase._init();

  static Database? _database;

  UsernameDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('username.db');
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
CREATE TABLE $usernamepack ( 
  ${Usernamefield.id} $idType, 
  ${Usernamefield.username} $textType

)
''');
  }

  Future<Username> create(Username username) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(usernamepack, username.toJson());
    return username.copy(id: id);
  }
  Future<Username> createByString(Username username) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(usernamepack, username.toJson());
    return username.copy(id: id);
  }
  Future<Username> readUsernamebyId(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      usernamepack,
      columns: Usernamefield.values,
      where: '${Usernamefield.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Username.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }



  Future<List<Username>> readAllUsernames() async {
    final db = await instance.database;


    //OrderByID
    final orderBy = '${Usernamefield.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(usernamepack, orderBy: orderBy);

    // print(result);

    return result.map((json) => Username.fromJson(json)).toList();
  }

  Future<int> update(Username username) async {
    final db = await instance.database;

    return db.update(
      usernamepack,
      username.toJson(),
      where: '${Usernamefield.id} = ?',
      whereArgs: [username.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      usernamepack,
      where: '${Usernamefield.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete2(String username) async {
    final db = await instance.database;

    return await db.delete(
        usernamepack,
        where: '${Usernamefield.username} = ?',
        whereArgs: [username]
    );
  }
  Future dropTable()async{
    final db = await instance.database;
    return
     await db.rawInsert('DELETE FROM username');
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
