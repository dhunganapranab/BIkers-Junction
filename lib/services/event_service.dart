// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/emergency.dart';
import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/models/eventRating.dart';
import 'package:bikers_junction_app/models/members.dart';
import 'package:bikers_junction_app/models/route_details.dart';
import 'package:bikers_junction_app/providers/emergency_provider.dart';
import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/providers/route_provider.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/eventDetails.dart';
import 'package:bikers_junction_app/screens/EmergencyDetails.dart';
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
        creatorID: creatorID,
      );

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainEvent(
                          directedFromCreateEvent: true,
                        )));
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
          List<dynamic> jsonData = jsonDecode(res.body);
          for (int i = 0; i < jsonData.length; i++) {
            Map<String, dynamic> eventData = jsonData[i];
            RouteDetails? routeDetails;
            if (eventData.containsKey('routeDetails')) {
              routeDetails = RouteDetails(
                routeName: eventData['routeDetails']['routeName'],
                startPointCoordinates: eventData['routeDetails']
                    ['startPointCoordinates'],
                destinationPointCoordinates: eventData['routeDetails']
                    ['destinationPointCoordinates'],
              );
            }
            eventList.add(
              Event(
                  id: eventData['_id'],
                  eventName: eventData['eventName'],
                  eventDescription: eventData['eventDescription'],
                  allowedParticipants: eventData['allowedParticipants'],
                  prerequisites: eventData['prerequisites'],
                  eventDate: eventData['eventDate'],
                  creatorName: eventData['creatorName'],
                  creatorID: eventData['creatorID'],
                  routeDetail: routeDetails,
                  member: List<Member>.from(
                      eventData['members']?.map((x) => Member.fromMap(x))),
                  ratings: List<Rating>.from(
                      eventData['ratings'].map((x) => Rating.fromMap(x)))),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return eventList;
  }

  void geteventDetails(
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
                context, EventDetails.routeName, (route) => true);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getmyeventDetails(
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
                context, MainEvent.routeName, (route) => true);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void createRoute(
      {required BuildContext context,
      required String routeName,
      required String startPointCoordinates,
      required String destinationPointCoordinates,
      required String eventID}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/events/addRouteDetails/$eventID'),
        body: jsonEncode({
          'routeName': routeName,
          'startPointCoordinates': startPointCoordinates,
          'destinationPointCoordinates': destinationPointCoordinates,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Route created successfully.');
            Navigator.pushNamedAndRemoveUntil(
                context, MainEvent.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Member>> getMembers(BuildContext context, String eventID) async {
    List<Member> members = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/$eventID/memberdetails'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            members.add(
              Member.fromJson(
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
      print(e.toString());
    }
    return members;
  }

  void kickMembers(
      {required BuildContext context,
      required String eventID,
      required String memberID}) async {
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/events/$eventID/kickmembers/$memberID'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(
                context, "You have kicked the ${memberID.substring(0, 7)}");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getRouteDetails(
      {required BuildContext context, required String eventID}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/$eventID/routedetails'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<RouteDetailProvider>(context, listen: false)
                .setRoute(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Emergency>> getEmergency(
      BuildContext context, String eventID) async {
    List<Emergency> emergencies = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/emergencies/$eventID'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            emergencies.add(
              Emergency.fromJson(
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
      print(e.toString());
    }
    return emergencies;
  }

  void getemergencyDetails(
      {required BuildContext context, required String emergencyID}) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/emergencyDetail/$emergencyID'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Provider.of<EmergencyProvider>(context, listen: false)
                .setEmergency(res.body);
            Navigator.pushNamedAndRemoveUntil(
                context, EmergencyDetailsScreen.routeName, (route) => true);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Rating>> getEventReviews(
      BuildContext context, String eventID) async {
    List<Rating> ratings = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/events/$eventID/ratings'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            ratings.add(
              Rating.fromJson(
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
      print(e.toString());
    }
    return ratings;
  }
}
