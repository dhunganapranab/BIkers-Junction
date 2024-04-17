import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();
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
                onPressed: () {
                  userService.logOut(context);
                },
                buttonText: const Text(
                  "logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ))),
      ],
    );
  }
}
