import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/models/route_details.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  Event _event = Event(
      id: '',
      eventName: '',
      eventDescription: '',
      allowedParticipants: '',
      prerequisites: '',
      eventDate: '',
      creatorName: '',
      creatorID: '',
      routeDetail: RouteDetails(
          routeName: '',
          startPointCoordinates: '',
          destinationPointCoordinates: ''),
      member: [],
      ratings: []);

  Event get event => _event;

  void setEvent(String event) {
    _event = Event.fromJson(event);
    notifyListeners();
  }
}
