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
            String userID = '6602ddebfd1978dec8616fa3';
            Message message =
                Message.fromJson(jsonEncode(jsonDecode(res.body)[i]));

            if (message.senderID != userID) {
              // Add the message to the messages list only if the sender's ID is different
              messages.add(message);
            }
            messages.forEach((message) {
              print(
                'Message: ${message.message}, Sender: ${message.senderName}, Type: ${message.type},${message.senderID}',
              );
            });
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return messages;
  }
}
