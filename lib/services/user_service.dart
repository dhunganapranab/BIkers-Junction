// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/user.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/createEvent.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
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

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userToken', '');
      Navigator.pushNamedAndRemoveUntil(
          context, Login.routeName, (route) => false);
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
      JoinEvent(
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

  void JoinEvent({
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
                context, MainEvent.routeName, (route) => false);
            print(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
