import 'dart:convert';

class Member {
  final String? id;
  final String name;
  final String email;
  final String userID;

  Member(
      {this.id, required this.name, required this.email, required this.userID});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userID': userID,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userID: map['userID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));
}
