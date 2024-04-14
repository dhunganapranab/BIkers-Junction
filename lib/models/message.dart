import 'dart:convert';

class Message {
  final String type;
  final String message;
  final String senderName;
  final String senderID;
  final String time;

  Message({
    required this.type,
    required this.message,
    required this.senderName,
    required this.senderID,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'message': message,
      'senderName': senderName,
      'senderID': senderID,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      type: map['type'] ?? '',
      message: map['message'] ?? '',
      senderName: map['senderName'] ?? '',
      senderID: map['senderID'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
