// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/emergency.dart';
import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/models/members.dart';
import 'package:bikers_junction_app/models/route_details.dart';
import 'package:bikers_junction_app/models/user.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/availableEvent.dart';
import 'package:bikers_junction_app/screens/createEvent.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  void signupUser({
    required BuildContext context,
    required String fullname,
    required String email,
    required String password,
    required String role,
    required String dateOfBirth,
  }) async {
    try {
      User user = User(
          id: '',
          fullname: fullname,
          email: email,
          password: password,
          dateOfBirth: dateOfBirth,
          role: role,
          token: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/user/register'),
        body: user.toJson(),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User registered successfully.');
            Navigator.pushNamedAndRemoveUntil(
                context, Login.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'Log in Successfull.');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString('userToken', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('userToken');

      if (userToken == null) {
        prefs.setString('userToken', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/api/user/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'userToken': userToken!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/user/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'userToken': userToken
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateProfile(
      {required BuildContext context,
      required String userID,
      required String name,
      required String email,
      required String dob}) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/user/$userID/updateProfile'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'dob': dob,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(
                context, 'Your details have been updated sucessfully.');
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void changePassword({
    required BuildContext context,
    required String userID,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/user/$userID/changepassword'),
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(
                context, 'Your password have been updated sucessfully.');
            Navigator.pop(context);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void sendResetPasswordEmail({
    required BuildContext context,
    required String email,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white38,
          ),
        );
      },
    );

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/send-reset-pass-email'),
        body: jsonEncode({'email': email}),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      Navigator.pop(context); // Dismiss the loader

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context,
                'Link for resetting password has been sent to your email.');
            Navigator.pop(context); // Close the current screen
            // Navigate to the desired page here
          });
    } catch (e) {
      Navigator.pop(context); // Dismiss the loader
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userToken', '');
      Navigator.pushNamedAndRemoveUntil(
          context, Login.routeName, (route) => false);
      showSnackBar(context, 'You have been logged out from the app.');
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void checkRoleCreator(BuildContext context, String role, String name) {
    if (role == 'Event Creator') {
      Navigator.pushNamedAndRemoveUntil(
          context, CreateEvent.routeName, (route) => true);
    } else {
      showSnackBar(
          context, "Hey $name !! You are paticipant. You cannot create event.");
    }
  }

  void checkRoleParticipant(BuildContext context, String role, String name,
      String eventID, String email, String userID) {
    if (role == 'Event Participator') {
      joinEvent(
          context: context,
          eventID: eventID,
          name: name,
          email: email,
          userID: userID);
    } else {
      showSnackBar(context,
          "Hey $name !! You are event creator. You cannot join other events.");
    }
  }

  void joinEvent({
    required BuildContext context,
    required String eventID,
    required String name,
    required String email,
    required String userID,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/joinevent'),
        body: jsonEncode({
          'eventId': eventID,
          'name': name,
          'email': email,
          'userID': userID,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'You have joined the event successfully.');
            Navigator.pushNamedAndRemoveUntil(
                context, MainEvent.routeName, (route) => true);
            print(res.body);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void leaveEvent({
    required BuildContext context,
    required String eventID,
    required String userID,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/$eventID/leaveevent'),
        body: jsonEncode({
          'userID': userID,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'You have left the event successfully.');
            Navigator.pushNamedAndRemoveUntil(
                context, AvailableEvents.routeName, (route) => false);
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Event>> getMyEvents(BuildContext context, String userID) async {
    List<Event> eventList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/user/$userID/myevent'),
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

  Future<List<Event>> getCreatedEvents(
      BuildContext context, String userID) async {
    List<Event> eventList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/user//createdEvent/$userID'),
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

  void initiateEmergency(
      {required BuildContext context,
      required String eventID,
      required String userName,
      required String userID,
      required String userLocation,
      required String message,
      required String time}) async {
    try {
      Emergency emergency = Emergency(
          id: '',
          eventID: eventID,
          userName: userName,
          userID: userID,
          userLocation: userLocation,
          message: message,
          time: time);

      http.Response res = await http.post(
        Uri.parse('$uri/api/user/initiateEmergency'),
        body: emergency.toJson(),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, '$userName has initiated the emergency!!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
