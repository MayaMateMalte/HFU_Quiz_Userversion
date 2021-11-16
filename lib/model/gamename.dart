/**
 * Created by Malte Denecke
 */


final String gamenamepack = 'gamename';


class Gamenamefield {
  static final List<String> values = [
    id,gamename,
  ];
  static final String id = '_id';
  static final String gamename = 'gamename';





}

class Gamename{

  final int? id;
  final String gamename;



  const Gamename({
    this.id,
    required this.gamename,

  });



  Gamename copy({
    int? id,
    String? username,


  })  => Gamename(
    id: id ?? this.id,
    gamename: username ?? this.gamename,

  );



  static Gamename fromJson(Map<String, Object?> json) => Gamename(
    id: json[Gamenamefield.id] as int?,
    gamename: json[Gamenamefield.gamename] as String,


  );




  Map<String, Object?> toJson() => {
    Gamenamefield.id: id,
    Gamenamefield.gamename : gamename,

  };

  @override
  String toString() {
    return 'Gamename{id: $id, gamename: $gamename}';
  }



}