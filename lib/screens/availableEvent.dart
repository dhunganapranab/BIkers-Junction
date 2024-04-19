import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/adminHomePage.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/services/admin_Service.dart';
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
  final AdminService adminService = AdminService();
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
    if (Provider.of<UserProvider>(context, listen: false).user.role ==
        "_admin") {
      eventService.getmyeventDetails(context: context, eventID: eventID);
    } else {
      eventService.geteventDetails(context: context, eventID: eventID);
    }
  }

  void deleteEvent(String eventID) {
    adminService.deleteEvent(context: context, eventID: eventID);
    setState(() {
      events!.removeWhere((event) => event.id == eventID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                child: Text("Available Events",
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
                          child: GridView.builder(
                              itemCount: events!.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: user.role == "_admin"
                                          ? 3.1 / 4
                                          : 3.3 / 4),
                              itemBuilder: (context, index) {
                                final eventData = events![index];
                                final averageRating =
                                    eventData.calculateAverageRating();
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
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        const Title1(
                                                          titleName:
                                                              "Event Rating: ",
                                                          fontSize: 16,
                                                        ),
                                                        Text(
                                                          "★ ${averageRating != null ? averageRating.toStringAsFixed(1) : '  Not Rated!'} ★",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: averageRating !=
                                                                      null
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)
                                                                  : const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      94,
                                                                      0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                right: 200.0,
                                                bottom: 10),
                                            child: CustomButton(
                                                width: 150,
                                                height: 35,
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
                                        user.role == "_admin"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 200.0),
                                                child: CustomButton(
                                                    width: 150,
                                                    height: 35,
                                                    color: const Color.fromARGB(
                                                        153, 255, 1, 1),
                                                    onPressed: () {
                                                      deleteEvent(eventData.id
                                                          as String);
                                                    },
                                                    buttonText: Text(
                                                        "Delete Event",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .cabin()
                                                                    .fontFamily,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))))
                                            : const SizedBox(),
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
                  user.role == "_admin"
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, AdminHomePage.routeName, (route) => false)
                      : Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
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
