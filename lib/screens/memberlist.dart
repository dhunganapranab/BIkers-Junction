import 'package:bikers_junction_app/models/members.dart';
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

class MembersListScreen extends StatefulWidget {
  static const String routeName = "/Eventmembers";
  final String eventID;
  const MembersListScreen({super.key, required this.eventID});

  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  List<Member>? members;
  final EventService eventService = EventService();

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  getMembers() async {
    members = await eventService.getMembers(context, widget.eventID);
    setState(() {});
  }

  void removeMember(String memberId) {
    eventService.kickMembers(
        context: context, eventID: widget.eventID, memberID: memberId);
    setState(() {
      members!.removeWhere((member) => member.id == memberId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double aspRatio = user.role == "Event Creator" ? 2.9 : 3.5;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
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
                const Title1(titleName: "Event Members"),
                Text(
                  "Here are the list of members joined in the event",
                  maxLines: 10,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                const SizedBox(height: 10),
                members == null || members!.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300.0),
                        child: Center(
                            child: Text(
                          "No members in the event!!",
                          style: TextStyle(color: Colors.white54),
                        )),
                      )
                    : Container(
                        height: screenHeight * 0.72,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: GridView.builder(
                            itemCount: members!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: aspRatio),
                            itemBuilder: (context, index) {
                              final memberData = members![index];
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
                                      titleName: memberData.name,
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Email: ${memberData.email}",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Member ID: ${memberData.id}",
                                      fontSize: 16,
                                    ),
                                    user.role == "Event Creator"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250.0),
                                            child: CustomButton(
                                              buttonText: const Text("Kick",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: const Color.fromARGB(
                                                  115, 255, 1, 1),
                                              onPressed: () {
                                                removeMember(
                                                    memberData.id as String);
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
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
