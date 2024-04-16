import 'dart:convert';

class Emergency {
  final String? id;
  final String eventID;
  final String userName;
  final String userID;
  final String userLocation;
  final String message;
  final String time;

  Emergency({
    required this.id,
    required this.eventID,
    required this.userName,
    required this.userID,
    required this.userLocation,
    required this.message,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventID': eventID,
      'userName': userName,
      'userID': userID,
      'userLocation': userLocation,
      'message': message,
      'time': time,
    };
  }

  factory Emergency.fromMap(Map<String, dynamic> map) {
    return Emergency(
      id: map['_id'] ?? '',
      eventID: map['eventID'] ?? '',
      userName: map['userName'] ?? '',
      userID: map['userID'] ?? '',
      userLocation: map['userLocation'] ?? '',
      message: map['message'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Emergency.fromJson(String source) =>
      Emergency.fromMap(json.decode(source));
}
