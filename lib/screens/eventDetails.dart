import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/EventReviews.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = '/eventDetails';
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final UserService userService = UserService();

  void _showJoinEventDialog(BuildContext context) {
    final event = Provider.of<EventProvider>(context, listen: false).event;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final user = Provider.of<UserProvider>(context).user;
        return AlertDialog(
          backgroundColor: const Color.fromARGB(171, 33, 61, 57),
          title: const Text(
            'Join Event Confirmation',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Do you really want to join this event?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            CustomButton(
              buttonText:
                  const Text("No", style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            CustomButton(
              buttonText:
                  const Text("Yes", style: TextStyle(color: Colors.white)),
              color: const Color.fromARGB(255, 54, 120, 244),
              onPressed: () {
                Navigator.of(context).pop();
                userService.checkRoleParticipant(context, user.role,
                    user.fullname, event.id as String, user.email, user.id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventProvider>(context).event;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: screenHeight * 0.69,
                    child: Card(
                      color: const Color.fromARGB(106, 184, 95, 95),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Title1(titleName: " Event Details"),
                            const SizedBox(height: 10),
                            CustomCard(
                                width: 400,
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
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily),
                                    ),
                                    const SizedBox(height: 30)
                                  ],
                                )),
                            CustomCard(
                                colors: const [
                                  Color.fromARGB(200, 111, 83, 83),
                                  Color.fromARGB(200, 19, 17, 17),
                                ],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Title1(titleName: "Pre-requisites"),
                                    Text(
                                      event.prerequisites,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily),
                                    ),
                                    const SizedBox(height: 30)
                                  ],
                                )),
                            CustomCard(
                                colors: const [
                                  Color.fromARGB(255, 154, 241, 91),
                                  Color.fromARGB(144, 114, 103, 0),
                                ],
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Title1(
                                          titleName: "Allowed Participants: ",
                                          fontSize: 20),
                                      Text(
                                        event.allowedParticipants,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily),
                                      ),
                                    ],
                                  ),
                                )),
                            CustomCard(
                                colors: const [
                                  Color.fromARGB(255, 28, 124, 235),
                                  Color.fromARGB(144, 187, 186, 174),
                                ],
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Title1(
                                              titleName: "Organizer: ",
                                              fontSize: 20),
                                          Text(
                                            event.creatorName,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: GoogleFonts.lato()
                                                    .fontFamily),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Title1(
                                              titleName: "Event Happeing On: ",
                                              fontSize: 20),
                                          Text(
                                            event.eventDate.substring(0, 10),
                                            maxLines: 10,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: GoogleFonts.lato()
                                                    .fontFamily),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 50.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showJoinEventDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 246, 150, 24),
                            minimumSize: const Size(150, 40)),
                        child: const Text(
                          "Join this Event",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventReviews(
                                      eventID: event.id as String)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(190, 0, 183, 255),
                            minimumSize: const Size(150, 40)),
                        child: const Text(
                          "See Reviews",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
