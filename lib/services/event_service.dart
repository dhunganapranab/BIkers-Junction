// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/eventDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EventService {
  void createEvent(
      {required BuildContext context,
      required String eventName,
      required String eventDescription,
      required String allowedParticipants,
      required String prerequisites,
      required String eventDate,
      required creatorName,
      required creatorID}) async {
    try {
      Event event = Event(
          id: '',
          eventName: eventName,
          eventDescription: eventDescription,
          allowedParticipants: allowedParticipants,
          prerequisites: prerequisites,
          eventDate: eventDate,
          creatorName: creatorName,
          creatorID: creatorID);

      http.Response res = await http.post(
        Uri.parse('$uri/api/events/createevent'),
        body: event.toJson(),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Event registered successfully.');
            Provider.of<EventProvider>(context, listen: false)
                .setEvent(res.body);
            Navigator.pushNamedAndRemoveUntil(
                context, MainEvent.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Event>> getallEvents(BuildContext context) async {
    List<Event> eventList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/availableevents'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            eventList.add(
              Event.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return eventList;
  }

  void geteventData(
      {required BuildContext context, required String eventID}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/events/eventDetails'),
        body: jsonEncode({
          'eventID': eventID,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<EventProvider>(context, listen: false)
                .setEvent(res.body);
            Navigator.pushNamedAndRemoveUntil(
                context, EventPage.routeName, (route) => true);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
