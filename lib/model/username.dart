/**
 * Created by Malte Denecke
 */
final String usernamepack = 'username';
class Usernamefield {
  static final List<String> values = [
    id,username,
  ];
  static final String id = '_id';
  static final String username = 'username';

}
class Username{

  final int? id;
  final String username;
  const Username({
    this.id,
    required this.username,

  });
  Username copy({
    int? id,
    String? username,
  })  => Username(
      id: id ?? this.id,
      username: username ?? this.username,

  );
  static Username fromJson(Map<String, Object?> json) => Username(
      id: json[Usernamefield.id] as int?,
      username: json[Usernamefield.username] as String,


  );
  Map<String, Object?> toJson() => {
    Usernamefield.id: id,
    Usernamefield.username : username,

  };

  @override
  String toString() {
    return 'Usernames{id: $id, gamename: $username}';
  }



}