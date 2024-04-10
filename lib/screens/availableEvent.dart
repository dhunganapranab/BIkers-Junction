import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:bikers_junction_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvailableEvents extends StatefulWidget {
  const AvailableEvents({super.key});
  static const String routeName = '/availableEvents';

  @override
  State<AvailableEvents> createState() => _AvailableEventsState();
}

class _AvailableEventsState extends State<AvailableEvents> {
  List<Event>? events;
  final EventService eventService = EventService();
  final UserService userService = UserService();
  String eventID = '';
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    events = await eventService.getallEvents(context);
    setState(() {});
  }

  void getEventData() {
    eventService.geteventData(context: context, eventID: eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            buttonText: "logout",
            onPressed: () {
              Navigator.pushNamed(context, 'logout');
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 450,
          decoration: BoxDecoration(
              color: const Color.fromARGB(124, 71, 71, 71),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 170.0, top: 10.0, bottom: 15),
                child: Text("Available Events",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    )),
              ),
              events == null
                  ? const Loader()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(26, 236, 227, 227),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: GridView.builder(
                              itemCount: events!.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3.6 / 4),
                              itemBuilder: (context, index) {
                                final eventData = events![index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromARGB(255, 180, 187, 85),
                                            Color.fromARGB(255, 41, 39, 39)
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/bike3.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          height: 200,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 15),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Title1(
                                                      titleName:
                                                          "Event Name: ${eventData.eventName}",
                                                      fontSize: 16,
                                                    ),
                                                    const Title1(
                                                      titleName:
                                                          "Route: A to B",
                                                      fontSize: 16,
                                                    ),
                                                    Title1(
                                                      titleName:
                                                          "Members: ${eventData.member!.length}",
                                                      fontSize: 16,
                                                    ),
                                                    Title1(
                                                      titleName:
                                                          "Event Date: ${eventData.eventDate.substring(0, 10)}",
                                                      fontSize: 16,
                                                    ),
                                                    Title1(
                                                      titleName:
                                                          "Organizer: ${eventData.creatorName}",
                                                      fontSize: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 200.0),
                                            child: CustomButton1(
                                                color: const Color.fromARGB(
                                                    255, 1, 255, 35),
                                                onPressed: () {
                                                  setState(() {
                                                    eventID =
                                                        eventData.id as String;
                                                  });
                                                  getEventData();
                                                },
                                                buttonText: Text("See details",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            GoogleFonts.cabin()
                                                                .fontFamily,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold)))),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                width: 300,
                height: 40,
                color: Colors.teal,
                buttonText: Text("Back to home",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.cabin().fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
