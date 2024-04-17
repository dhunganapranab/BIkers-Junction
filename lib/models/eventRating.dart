import 'dart:convert';

class Rating {
  final int rating;
  final String reviewMessage;
  final String userName;
  final String userID;

  Rating({
    required this.rating,
    required this.reviewMessage,
    required this.userName,
    required this.userID,
  });

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'reviewMessage': reviewMessage,
      'username': userName,
      'userID': userID,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rating: map['rating'] ?? '',
      reviewMessage: map['reviewMessage'] ?? '',
      userName: map['userName'] ?? '',
      userID: map['userID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
