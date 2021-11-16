/**
 * Created by Malte Denecke
 */
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:classroomquiz_usersedition/model/questions.dart';



class QuestionsDatabase {
  static final QuestionsDatabase instance = QuestionsDatabase._init();

  static Database? _database;

  QuestionsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('questions.db');
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
CREATE TABLE $questionspack ( 
  ${Questionsfield.id} $idType, 
  ${Questionsfield.gamename} $textType,
  ${Questionsfield.questiontext} $textType,
  ${Questionsfield.answer1} $textType,
  ${Questionsfield.answer2} $textType,
  ${Questionsfield.answer3} $textType,
    ${Questionsfield.answer4} $textType,
  ${Questionsfield.solution} $textType,
  ${Questionsfield.categoryid} $integerType
)
''');
  }

  Future<Questions> create(Questions questions) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(questionspack, questions.toJson());
    return questions.copy(id: id);
  }

  Future<Questions> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      questionspack,
      columns: Questionsfield.values,
      where: '${Questionsfield.id} = ?',
      whereArgs: [id],
    );





    if (maps.isNotEmpty) {
      return Questions.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Questions> readNotebyQuestiontext(String questiontext) async {
    final db = await instance.database;

    final maps = await db.query(
      questionspack,
      columns: Questionsfield.values,
      where: '${Questionsfield.questiontext} = ?',
      whereArgs: [questiontext],
    );
    if (maps.isNotEmpty) {
      print("Eintrag wurde gefunden");
      print(questiontext);
      return Questions.fromJson(maps.first);
    } else {
      throw Exception('ID $questiontext not found');

    }
  }

  Future<bool> readbyQuestiontextAndCheckforExisting(String questiontext) async {
    final db = await instance.database;

    final maps = await db.query(
      questionspack,
      columns: Questionsfield.values,
      where: '${Questionsfield.questiontext} = ?',
      whereArgs: [questiontext],
    );
    if (maps.isNotEmpty) {
      print("Eintrag wurde gefunden");
      print(questiontext);
      return true;
    } else {
      return false;

    }
  }



  Future<List<Questions>> readAllQuestions() async {
    final db = await instance.database;


    //OrderByID
    final orderBy = '${Questionsfield.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(questionspack, orderBy: orderBy);

    // print(result);

    return result.map((json) => Questions.fromJson(json)).toList();
  }

  Future<int> update(Questions questions) async {
    final db = await instance.database;

    return db.update(
      questionspack,
      questions.toJson(),
      where: '${Questionsfield.id} = ?',
      whereArgs: [questions.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      questionspack,
      where: '${Questionsfield.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete2(String gamename) async {
    final db = await instance.database;

    return await db.delete(
      questionspack,
      where: '${Questionsfield.gamename} = ?',
      whereArgs: [gamename]
    );
  }
  Future dropTable()async{
    final db = await instance.database;
    return
      await db.rawInsert('DELETE FROM questions');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
