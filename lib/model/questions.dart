/**
 * Created by Malte Denecke
 */


final String questionspack = 'questions';


class Questionsfield {
  static final List<String> values = [
    id,gamename,questiontext,answer1,answer2,answer3,answer4,solution,categoryid
  ];
  static final String id = '_id';
  static final String gamename = 'gamename';
  static final String questiontext = 'questiontext';
  static final String answer1 = 'answer1';
  static final String answer2 = 'answer2';
  static final String answer3 = 'answer3';
  static final String answer4 = 'answer4';
  static final String solution = 'solution';
  static final String categoryid = 'categoryid';




}

class Questions{

  final int? id;
  final String gamename;
  final String questiontext;
  final String answer1;
  final String answer2;
  final String answer3 ;
  final String answer4;
  final String solution;
  final int categoryid;


  const Questions({
    this.id,
    required this.gamename,
    required this.questiontext,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.solution,
    required this.categoryid
  });




  Questions copy({
    int? id,
    String? gamename,
    String? questiontext,
    String? answer1,
    String? answer2,
    String? answer3,
    String? answer4,
    String? solution,
    int? categoryid,

  })  => Questions(
      id: id ?? this.id,
      gamename: gamename ?? this.gamename,
      questiontext: questiontext ?? this.questiontext,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
      answer3: answer3 ?? this.answer3,
      answer4: answer4 ?? this.answer4,
      solution: solution ?? this.solution,
      categoryid: categoryid ?? this.categoryid
  );



  static Questions fromJson(Map<String, Object?> json) => Questions(
      id: json[Questionsfield.id] as int?,
      gamename: json[Questionsfield.gamename] as String,
      questiontext: json[Questionsfield.questiontext] as String,
      answer1: json[Questionsfield.answer1] as String,
      answer2: json[Questionsfield.answer2] as String,
      answer3: json[Questionsfield.answer3] as String,
      answer4: json[Questionsfield.answer4] as String,
      solution: json[Questionsfield.solution] as String,
      categoryid: json[Questionsfield.categoryid] as int

  );

  factory Questions.fromJsonApi(Map<String, dynamic> json)  => Questions(
      id: json["id"] as int?,
      gamename: json["gamename"],
      questiontext: json["questiontext"] ,
      answer1: json["answer1"],
      answer2: json["answer2"],
      answer3:json["answer3"] ,
      answer4: json["answer4"],
      solution: json["solution"],
      categoryid: json["categoryid"]
  );



  Map<String, Object?> toJson() => {
    Questionsfield.id: id,
    Questionsfield.gamename : gamename,
    Questionsfield.questiontext: questiontext,
    Questionsfield.answer1 : answer1,
    Questionsfield.answer2 : answer2,
    Questionsfield.answer3 : answer3,
    Questionsfield.answer4 : answer4,
    Questionsfield.solution : solution,
    Questionsfield.categoryid : categoryid
  };

  @override
  String toString() {
    return 'Questions{id: $id, gamename: $gamename, questiontext: $questiontext, answer1: $answer1, answer2: $answer2, answer3: $answer3, answer4: $answer4, solution: $solution, categoryid: $categoryid}';
  }



}