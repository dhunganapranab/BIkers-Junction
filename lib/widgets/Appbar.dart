import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomAppbar({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Center(
          child: Text(
        "Biker's Junction",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      iconTheme: const IconThemeData(color: Colors.white, size: 38),
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomButton(
                onPressed: onPressed,
                buttonText: Text(
                  buttonText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ))),
      ],
    );
  }
}
