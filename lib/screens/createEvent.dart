import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  static const String routeName = "/createEvent";

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  EventService eventService = EventService();
  TextEditingController eventName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController participants = TextEditingController();
  TextEditingController eventRequirement = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String eventDate = DateTime.now().toString();

  void setDate() {
    setState(() {
      eventDate =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    });
  }

  void createEvent(String creatorName, String creatorID) {
    eventService.createEvent(
        context: context,
        eventName: eventName.text,
        eventDescription: description.text,
        allowedParticipants: participants.text,
        prerequisites: eventRequirement.text,
        eventDate: eventDate,
        creatorName: creatorName,
        creatorID: creatorID);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final UserService userService = UserService();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg2.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 70.0),
            child: SizedBox(
              width: 400,
              height: 700,
              child: Form(
                key: _formKey,
                child: Card(
                  color: const Color.fromARGB(50, 52, 46, 46),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(150, 224, 207, 207), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 2.0),
                    child: Scrollbar(
                      radius: const Radius.circular(10.0),
                      thickness: 4.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 25, bottom: 10.0),
                              child: Text(
                                "Enter event details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.cabin().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 240.0),
                                    child: Label1(labelName: "Event Name"),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 100.0),
                                      child: CustomTextField(
                                          controller: eventName,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "field cannot be empty!!!";
                                            }
                                            return null;
                                          },
                                          hintText: "Enter event name",
                                          width: 250)),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 240.0),
                                    child: Label1(labelName: "Description"),
                                  ),
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                      child: CustomTextField(
                                          controller: description,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "field cannot be empty!!!";
                                            }
                                            return null;
                                          },
                                          hintText: "Enter event description",
                                          maxLines: 5,
                                          height: 100)),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Label1(
                                            labelName:
                                                "Allowed number \n of participants: "),
                                        const Spacer(),
                                        CustomTextField(
                                            controller: participants,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "field cannot be empty!!!";
                                              }
                                              return null;
                                            },
                                            width: 140,
                                            hintText: "No.of participants",
                                            keyboardType: TextInputType.number),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 100.0),
                                    child: Label1(
                                        labelName:
                                            "Pre-requisites for joining this\nevent**"),
                                  ),
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                      child: CustomTextField(
                                          controller: eventRequirement,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "field cannot be empty!!!";
                                            }
                                            return null;
                                          },
                                          hintText:
                                              "Enter pre-requisites here..",
                                          maxLines: 5,
                                          height: 100)),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Label1(labelName: "Event Date:"),
                                      Text(
                                        "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                            fontSize: 14),
                                      ),
                                      CustomButton(
                                          onPressed: () async {
                                            final DateTime? dateTime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: selectedDate,
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(3000));

                                            if (dateTime != null) {
                                              setState(() {
                                                selectedDate = dateTime;
                                              });
                                            }
                                          },
                                          width: 100,
                                          color: const Color.fromARGB(
                                              255, 104, 21, 90),
                                          buttonText: const Text("Choose Date",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CustomButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setDate();
                                          createEvent(user.fullname, user.id);
                                        }
                                      },
                                      width: 120,
                                      color: const Color.fromARGB(
                                          255, 46, 161, 71),
                                      buttonText: const Text("Create Event",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
