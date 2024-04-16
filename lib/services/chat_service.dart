// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bikers_junction_app/constants/error_handling.dart';
import 'package:bikers_junction_app/constants/global_variables.dart';
import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/models/message.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatService {
  Future<List<Message>> getchathistory(
      BuildContext context, String eventID) async {
    List<Message> messages = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/chat/$eventID/messagehistory'),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            Message message =
                Message.fromJson(jsonEncode(jsonDecode(res.body)[i]));
            messages.add(message);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return messages;
  }
}
