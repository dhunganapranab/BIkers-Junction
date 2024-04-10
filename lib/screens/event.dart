import 'package:bikers_junction_app/screens/event_chat.dart';
import 'package:bikers_junction_app/screens/planRoute.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

class MainEvent extends StatefulWidget {
  static const String routeName = "/eventScreen";
  const MainEvent({super.key});

  @override
  State<MainEvent> createState() => _MainEventState();
}

class _MainEventState extends State<MainEvent> {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventProvider>(context).event;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(buttonText: "logout", onPressed: () {})),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomCard(
                      width: screenWidth,
                      colors: const [
                        Color.fromARGB(100, 84, 183, 255),
                        Color.fromARGB(50, 2, 2, 2),
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Title1(titleName: event.eventName),
                          Text(
                            event.eventDescription,
                            maxLines: 10,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: GoogleFonts.lato().fontFamily),
                          ),
                          const SizedBox(height: 30)
                        ],
                      )),
                  CustomCard(
                      width: screenWidth,
                      height: screenHeight * 0.738,
                      colors: const [
                        Color.fromARGB(200, 111, 83, 83),
                        Color.fromARGB(200, 19, 17, 17),
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardButton(
                              onPressed: () {},
                              imagePath: 'assets/member.png',
                              imageLabel: 'Members',
                              buttonText:
                                  "See people who have\nparticipated on the event.",
                              colors: const [
                                Color.fromARGB(112, 63, 56, 37),
                                Color.fromARGB(110, 105, 100, 100)
                              ]),
                          CardButton(
                              imagePath: 'assets/chatImage.png',
                              imageLabel: 'Group Chat',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    EventChat.routeName, (route) => true);
                              },
                              buttonText:
                                  "Chat with event\nmembers and discuss ride.",
                              colors: const [
                                Color.fromARGB(228, 216, 62, 62),
                                Color.fromARGB(178, 216, 62, 62),
                                Color.fromARGB(155, 44, 41, 41)
                              ]),
                          CardButton(
                              imagePath: 'assets/routeImage.png',
                              imageLabel: 'Route Details',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    PlanRoute.routeName, (route) => true);
                              },
                              buttonText: "See route details for trip.",
                              colors: const [
                                Color.fromARGB(227, 58, 156, 148),
                                Color.fromARGB(227, 58, 156, 148),
                                Color.fromARGB(155, 44, 41, 41)
                              ]),
                          CardButton(
                              imagePath: 'assets/emergency.png',
                              imageLabel: 'Emergency',
                              onPressed: () {},
                              buttonText: "Call emergency alert",
                              colors: const [
                                Color.fromARGB(228, 216, 62, 62),
                                Color.fromARGB(178, 216, 62, 62),
                                Color.fromARGB(155, 44, 41, 41)
                              ])
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 240.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'available events');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 246, 24, 24),
                          minimumSize: const Size(150, 40)),
                      child: const Text(
                        "Leave Event",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
