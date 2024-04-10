import 'dart:convert';
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

  Event(
      {required this.id,
      required this.eventName,
      required this.eventDescription,
      required this.allowedParticipants,
      required this.prerequisites,
      required this.eventDate,
      required this.creatorName,
      required this.creatorID,
      this.member,
      this.routeDetail});

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
      'routeDetails': routeDetail,
      'members': member
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
            ? RouteDetails(
                routeName: map['routeDetail']['routeName'] ?? '',
                startPointCoordinates:
                    map['routeDetail']['startPointCoordinates'] ?? '',
                destinationPointCoordinates:
                    map['routeDetail']['destinationPointCoordinates'] ?? '',
              )
            : RouteDetails(
                routeName:
                    '', // Provide default values or handle null case as needed
                startPointCoordinates: '',
                destinationPointCoordinates: '',
              ),
        member: map['members'] != null
            ? List<Member>.from(map['members']?.map((x) => Member.fromMap(x)))
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
