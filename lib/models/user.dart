import 'dart:convert';

class User {
  final String id;
  final String fullname;
  final String email;
  final String password;
  final String dateOfBirth;
  final String token;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
