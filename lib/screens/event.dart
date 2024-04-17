import 'dart:async';

import 'package:bikers_junction_app/constants/utils.dart';
import 'package:bikers_junction_app/providers/route_provider.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/emergenciesList.dart';
import 'package:bikers_junction_app/screens/event_chat.dart';
import 'package:bikers_junction_app/screens/memberlist.dart';
import 'package:bikers_junction_app/screens/planRoute.dart';
import 'package:bikers_junction_app/screens/routeDetails.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/map_services.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';

class MainEvent extends StatefulWidget {
  static const String routeName = "/eventScreen";
  const MainEvent({Key? key}) : super(key: key);

  @override
  State<MainEvent> createState() => _MainEventState();
}

class _MainEventState extends State<MainEvent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();
  EventService eventService = EventService();
  UserService userService = UserService();
  MapServices mapservices = MapServices();
  double lat = 0.0, long = 0.0;
  String location = "";
  String userID = "";
  String eventID = "";
  String userName = "";
  String time = DateFormat('yyyy-MM-dd , HH:mm').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getRouteDetails();
  }

  void getRouteDetails() {
    eventService.getRouteDetails(
        context: context,
        eventID: Provider.of<EventProvider>(context, listen: false).event.id
            as String);
  }

  void initiateEmergency(String eventID, String userName, String userID,
      String userLocation, String message, String time) {
    userService.initiateEmergency(
        context: context,
        eventID: eventID,
        userName: userName,
        userID: userID,
        userLocation: userLocation,
        message: message,
        time: time);
  }

  void _getCurrentLocationAndShowDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          content: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 156, 156, 156),
            ), // Show a CircularProgressIndicator as a loader
          ),
        );
      },
    );

    mapservices.getCurrentLocation().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      Navigator.of(context).pop(); // Dismiss the loader dialog
      _showInitiateEmergencyDialog(
          context); // Show the dialog after updating lat and long
    });
  }

  void _showInitiateEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(171, 33, 61, 57),
          title: const Text(
            'Initiate Emergency!!',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 83, 3),
                fontWeight: FontWeight.bold),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
          content: SizedBox(
            height: 80,
            child: Column(
              children: [
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Title1(
                          titleName: "Your current Location:",
                          fontSize: 15,
                        ),
                        const SizedBox(width: 10),
                        Title1(
                          titleName: "$lat,$long",
                          fontSize: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                lat == 0.0 && long == 0.0
                    ? const SizedBox()
                    : const Title1(
                        titleName: "Do you really want to initiate emergency??",
                        color: Color.fromARGB(255, 255, 0, 55),
                        fontSize: 17,
                      )
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    buttonText:
                        const Text("No", style: TextStyle(color: Colors.white)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop(); // Closes the dialog
                    },
                  ),
                  CustomButton(
                    buttonText: const Text("Yes",
                        style: TextStyle(color: Colors.white)),
                    color: const Color.fromARGB(255, 54, 120, 244),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close current dialog
                      _showMessageDialog(context);
                      setState(() {
                        location = "$lat,$long";
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(204, 8, 19, 17),
          title: const Title1(
            titleName: "Emergency Message",
            fontSize: 18,
            color: Colors.redAccent,
          ),
          content: Form(
            key: formKey,
            child: CustomTextField(
              controller: message,
              validator: (value) {
                if (value!.isEmpty) {
                  return "field cannot be empty!!!";
                }
                return null;
              },
              hintText: "Enter your message",
            ),
          ),
          actions: [
            CustomButton(
              width: 100,
              buttonText:
                  const Text("cancel", style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            CustomButton(
              width: 100,
              buttonText:
                  const Text("Submit", style: TextStyle(color: Colors.white)),
              color: const Color.fromARGB(255, 1, 255, 1),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  initiateEmergency(
                      eventID, userName, userID, location, message.text, time);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final route = Provider.of<RouteDetailProvider>(context).route;
    final event = Provider.of<EventProvider>(context).event;
    final user = Provider.of<UserProvider>(context).user;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
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
                  user.role == "Event Creator"
                      ? Padding(
                          padding: const EdgeInsets.only(right: 220.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  PlanRoute.routeName, (route) => true);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 7, 240, 27),
                                minimumSize: const Size(150, 40)),
                            child: const Text(
                              "Plan or Edit Route",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(right: 220.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _getCurrentLocationAndShowDialog(context);
                        setState(() {
                          eventID = event.id as String;
                          userID = user.id;
                          userName = user.fullname;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 123, 0),
                          minimumSize: const Size(150, 40)),
                      child: const Text(
                        "Call Emergency!!!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MembersListScreen(
                                            eventID: event.id as String)));
                              },
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventChat(
                                            eventID: event.id as String)));
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
                                if (route.routeName == "") {
                                  showSnackBar(context,
                                      "Route details are not added by event organizer yet!!");
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RouteDetailScreen(
                                              startpoint:
                                                  route.startPointCoordinates,
                                              destination: route
                                                  .destinationPointCoordinates)));
                                }
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EmergencyListScreen(
                                                eventID: event.id as String)));
                              },
                              buttonText: "See emergency Details",
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
                  CustomCard(
                    colors: const [
                      Color.fromARGB(172, 0, 0, 0),
                      Color.fromARGB(146, 0, 0, 0)
                    ],
                    child: Column(
                      children: [
                        const Text(
                          "If you want to provide rating and review to the event?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            onPressed: () {},
                            width: screenWidth * 0.5,
                            color: const Color.fromARGB(255, 255, 147, 7),
                            buttonText: const Text(
                              "Click here!!",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  user.role == "Event Creator"
                      ? const SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            userService.leaveEvent(
                                context: context,
                                eventID: event.id as String,
                                userID: user.id);
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
                  const SizedBox(height: 5),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 250,
                    height: 40,
                    color: const Color.fromARGB(255, 135, 150, 0),
                    buttonText: Text("Back",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.cabin().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
