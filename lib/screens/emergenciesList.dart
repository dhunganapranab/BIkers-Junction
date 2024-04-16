import 'package:bikers_junction_app/models/emergency.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmergencyListScreen extends StatefulWidget {
  static const String routeName = "/eventEmergencies";
  final String eventID;
  const EmergencyListScreen({super.key, required this.eventID});

  @override
  State<EmergencyListScreen> createState() => _EmergencyListScreenState();
}

class _EmergencyListScreenState extends State<EmergencyListScreen> {
  List<Emergency>? emergencies;
  final EventService eventService = EventService();

  @override
  void initState() {
    super.initState();
    getEmergency();
  }

  getEmergency() async {
    emergencies = await eventService.getEmergency(context, widget.eventID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double aspRatio = user.role == "Event Creator" ? 2.4 : 2.4;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(buttonText: "logout", onPressed: () {})),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CustomCard(
            width: screenWidth,
            colors: const [
              Color.fromARGB(184, 82, 44, 23),
              Color.fromARGB(48, 37, 105, 102),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Title1(titleName: "Event Emergencies"),
                Text(
                  "Here are the list of emergencies initiated in the event",
                  maxLines: 10,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                const SizedBox(height: 10),
                emergencies == null
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300.0),
                        child: Center(
                            child: Text(
                          "No emergencies initiated!!",
                          style: TextStyle(color: Colors.white54),
                        )),
                      )
                    : Container(
                        height: screenHeight * 0.72,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: GridView.builder(
                            itemCount: emergencies!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: aspRatio),
                            itemBuilder: (context, index) {
                              final emergencyData = emergencies![index];
                              return CustomCard(
                                width: screenWidth,
                                height: 50,
                                colors: const [
                                  Color.fromARGB(97, 191, 255, 40),
                                  Color.fromARGB(108, 86, 107, 61),
                                ],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Title1(
                                      titleName:
                                          "ID: ${emergencyData.id?.substring(0, 10)}",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName:
                                          "Initiator : ${emergencyData.userName} ",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName:
                                          "Initiator ID: ${emergencyData.userID.substring(0, 10)} ",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Time: ${emergencyData.time} ",
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                          width: 200,
                                          buttonText: const Text(
                                              "See Emergency Details",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          color: const Color.fromARGB(
                                              209, 1, 255, 35),
                                          onPressed: () {
                                            eventService.getemergencyDetails(
                                                context: context,
                                                emergencyID:
                                                    emergencyData.id as String);
                                          },
                                        ),
                                        user.role == "Event Creator"
                                            ? CustomButton(
                                                buttonText: const Text(
                                                    "Dismiss",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                color: const Color.fromARGB(
                                                    115, 255, 1, 1),
                                                onPressed: () {},
                                              )
                                            : const SizedBox()
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
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
