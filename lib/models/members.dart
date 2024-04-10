import 'dart:convert';

class Member {
  final String name;
  final String email;
  final String userID;

  Member({required this.name, required this.email, required this.userID});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'userID': userID,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userID: map['userID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromMap(json.decode(source));
}
