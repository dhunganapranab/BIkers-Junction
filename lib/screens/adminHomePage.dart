import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/availableEvent.dart';
import 'package:bikers_junction_app/screens/emergenciesList.dart';
import 'package:bikers_junction_app/screens/memberlist.dart';
import 'package:bikers_junction_app/screens/userListAdmin.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  static const String routeName = '/adminHomePage';
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Title1(
                titleName: "Welcome Admin!!",
                fontSize: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, UserListScreen.routeName, (route) => true);
                      },
                      imagePath: 'assets/member.png',
                      imageLabel: 'Users',
                      buttonText: "See users on the system.",
                      colors: const [
                        Color.fromARGB(112, 63, 56, 37),
                        Color.fromARGB(109, 187, 155, 155)
                      ]),
                  CardButton(
                      imagePath: 'assets/events.png',
                      imageLabel: 'Events',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            AvailableEvents.routeName, (route) => true);
                      },
                      buttonText:
                          "See all the events available\non the system.",
                      colors: const [
                        Color.fromARGB(227, 216, 213, 62),
                        Color.fromARGB(177, 62, 216, 183),
                        Color.fromARGB(155, 44, 41, 41)
                      ]),
                  CardButton(
                      imagePath: 'assets/emergency.png',
                      imageLabel: 'Emergency',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmergencyListScreen()));
                      },
                      buttonText: "See emergency Details",
                      colors: const [
                        Color.fromARGB(228, 216, 62, 62),
                        Color.fromARGB(178, 216, 62, 62),
                        Color.fromARGB(155, 44, 41, 41)
                      ])
                ],
              )
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
