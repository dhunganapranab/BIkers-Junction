// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/emergency.dart';
import 'package:bikers_junction_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminService {
  Future<List<User>> getUsers(BuildContext context) async {
    List<User> users = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/admin/getallusers'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            users.add(
              User.fromJson(
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
    return users;
  }

  Future<List<Emergency>> getAllEmergencies(BuildContext context) async {
    List<Emergency> emergencies = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/admin/getallemergencies'),
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

  void deleteUser(
      {required BuildContext context, required String userID}) async {
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/admin/deleteuser/$userID'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context,
                "You have deleted the user with id: ${userID.substring(0, 7)}");
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  void deleteEvent(
      {required BuildContext context, required String eventID}) async {
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/admin/deleteevent/$eventID'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context,
                "You have deleted the event with id: ${eventID.substring(0, 7)}");
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
