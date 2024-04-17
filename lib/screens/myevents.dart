import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:bikers_junction_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyEvents extends StatefulWidget {
  static const String routeName = "/myEventRoute";
  final String userID;
  final String role;
  const MyEvents({super.key, required this.userID, required this.role});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  List<Event>? events;
  final EventService eventService = EventService();
  final UserService userService = UserService();
  String eventID = "";

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    if (widget.role == "Event Creator") {
      events = await userService.getCreatedEvents(context, widget.userID);
      setState(() {});
    } else {
      events = await userService.getMyEvents(context, widget.userID);
      setState(() {});
    }
  }

  void getEventData() {
    eventService.getmyeventDetails(context: context, eventID: eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar()),
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
                child: Text("Your Joined Events",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    )),
              ),
              events == null || events!.isEmpty
                  ? const Loader()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(26, 236, 227, 227),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: events == null || events!.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No events found!!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : GridView.builder(
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
                                                Color.fromARGB(
                                                    255, 180, 187, 85),
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
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 15),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Title1(
                                                          titleName:
                                                              "Event Name: ${eventData.eventName}",
                                                          fontSize: 16,
                                                        ),
                                                        Title1(
                                                          titleName:
                                                              "Route: ${eventData.routeDetail?.routeName ?? " Not defined "}",
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
                                                      eventID = eventData.id
                                                          as String;
                                                      getEventData();
                                                    },
                                                    buttonText: Text(
                                                        "See details",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .cabin()
                                                                    .fontFamily,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)))),
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
