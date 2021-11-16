/**
 * Created by Malte Denecke
 */

import 'dart:core';


final String incorrectCorrectAnsweredpack = 'incorrectCorrectAnswered';


class IncorrectCorrectAnsweredfield {
  static final List<String> values = [
    id,questiontext,iscorrect,gamename,gamecounter
  ];
  static final String id = '_id';
  static final String questiontext = 'questiontext';
  static final String iscorrect = 'iscorrect';
  static final String gamename = 'gamename';
  static final String gamecounter = 'gamecounter';





}

class IncorrectCorrectAnswered{

  final int? id;
  final String questiontext;
  final String iscorrect;
  final String gamename;
  final int? gamecounter;




  const IncorrectCorrectAnswered({
    this.id,
    required this.questiontext,
    required this.iscorrect,
    required this.gamename,
    required this.gamecounter,
  });



  IncorrectCorrectAnswered copy({
    int? id,
    String? questiontext,
    String? iscorrect,
    String? gamename,
    int? gamecounter



  })  => IncorrectCorrectAnswered(
    id: id ?? this.id,
    questiontext: questiontext ?? this.questiontext,
      iscorrect: iscorrect ?? this.iscorrect,
    gamename: gamename ?? this.gamename,
    gamecounter: gamecounter ?? this.gamecounter

  );



  static IncorrectCorrectAnswered fromJson(Map<String, Object?> json) => IncorrectCorrectAnswered(
    id: json[IncorrectCorrectAnsweredfield.id] as int?,
    questiontext: json[IncorrectCorrectAnsweredfield.questiontext] as String,
    iscorrect: json[IncorrectCorrectAnsweredfield.iscorrect] as String,
    gamename: json[IncorrectCorrectAnsweredfield.gamename] as String,
      gamecounter: json[IncorrectCorrectAnsweredfield.gamecounter] as int


  );




  Map<String, Object?> toJson() => {
    IncorrectCorrectAnsweredfield.id: id,
    IncorrectCorrectAnsweredfield.questiontext : questiontext,
    IncorrectCorrectAnsweredfield.iscorrect: iscorrect,
    IncorrectCorrectAnsweredfield.gamename: gamename,
    IncorrectCorrectAnsweredfield.gamecounter: gamecounter


  };

  @override
  String toString() {
    return 'IncorrectCorrectAnswered{id: $id, questiontext: $questiontext, iscorrect: $iscorrect, gamename: $gamename,  gamecouner: $gamecounter}';
  }



}