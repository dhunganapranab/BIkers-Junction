import 'package:flutter/material.dart';

Future<void> showSnackBar(BuildContext context, String text) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
