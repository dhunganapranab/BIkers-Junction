import 'dart:convert';
import 'package:bikers_junction_app/models/eventRating.dart';
import 'package:bikers_junction_app/models/members.dart';
import 'package:bikers_junction_app/models/route_details.dart';

class Event {
  final String? id;
  final String eventName;
  final String eventDescription;
  final String allowedParticipants;
  final String prerequisites;
  final String eventDate;
  final String creatorName;
  final String creatorID;
  final RouteDetails? routeDetail;
  final List<Member>? member;
  final List<Rating>? ratings;

  Event({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.allowedParticipants,
    required this.prerequisites,
    required this.eventDate,
    required this.creatorName,
    required this.creatorID,
    this.member,
    this.routeDetail,
    this.ratings,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventName': eventName,
      'eventDescription': eventDescription,
      'allowedParticipants': allowedParticipants,
      'prerequisites': prerequisites,
      'eventDate': eventDate,
      'creatorName': creatorName,
      'creatorID': creatorID,
      'routeDetails': routeDetail?.toMap(),
      'members': member?.map((x) => x.toMap()).toList(),
      'ratings': ratings?.map((x) => x.toMap()).toList(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['_id'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      allowedParticipants: map['allowedParticipants'] ?? '',
      prerequisites: map['prerequisites'] ?? '',
      eventDate: map['eventDate'] ?? '',
      creatorName: map['creatorName'] ?? '',
      creatorID: map['createdBy'] ?? '',
      routeDetail: map['routeDetail'] != null
          ? RouteDetails.fromMap(map['routeDetail'])
          : null,
      member: map['members'] != null
          ? List<Member>.from(map['members'].map((x) => Member.fromMap(x)))
          : null,
      ratings: map['ratings'] != null
          ? List<Rating>.from(map['ratings'].map((x) => Rating.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  double? calculateAverageRating() {
    if (ratings == null || ratings!.isEmpty) {
      return null; // Return null if there are no ratings
    }

    double totalRating = 0;
    for (var rating in ratings!) {
      totalRating += rating.rating;
    }

    return totalRating / ratings!.length;
  }
}
