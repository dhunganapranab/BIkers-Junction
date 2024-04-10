import 'package:bikers_junction_app/models/event.dart';
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
      member: []);

  Event get event => _event;

  void setEvent(String event) {
    _event = Event.fromJson(event);
    notifyListeners();
  }
}
