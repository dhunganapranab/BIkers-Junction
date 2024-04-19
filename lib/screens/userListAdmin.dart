import 'package:bikers_junction_app/models/emergency.dart';
import 'package:bikers_junction_app/models/user.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/services/admin_service.dart';
import 'package:bikers_junction_app/services/event_service.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Card.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = "/systemUsers";

  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User>? users;
  final UserService userService = UserService();
  final EventService eventService = EventService();
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers() async {
    users = await adminService.getUsers(context);
    setState(() {});
  }

  void deleteUser(String userID) {
    adminService.deleteUser(context: context, userID: userID);
    setState(() {
      users!.removeWhere((user) => user.id == userID);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                const Title1(titleName: "System Users"),
                Text(
                  "Here is the list of users in the system",
                  maxLines: 10,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                const SizedBox(height: 10),
                users == null || users!.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 300.0),
                        child: Center(
                            child: Text(
                          "No users in the system!!",
                          style: TextStyle(color: Colors.white54),
                        )),
                      )
                    : Container(
                        height: screenHeight * 0.72,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: GridView.builder(
                            itemCount: users!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 2.0),
                            itemBuilder: (context, index) {
                              final userData = users![index];
                              return CustomCard(
                                width: screenWidth,
                                height: 50,
                                colors: const [
                                  Color.fromARGB(96, 40, 255, 165),
                                  Color.fromARGB(108, 86, 107, 61),
                                ],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Title1(
                                      titleName:
                                          "ID: ${userData.id.substring(0, 7)}",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Name: ${userData.fullname}  ",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Email: ${userData.email} ",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName: "Role: ${userData.role} ",
                                      fontSize: 16,
                                    ),
                                    Title1(
                                      titleName:
                                          "DOB: ${userData.dateOfBirth} A.D. ",
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
                                          width: 150,
                                          buttonText: const Text("Delete User",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          color: const Color.fromARGB(
                                              209, 255, 39, 1),
                                          onPressed: () {
                                            deleteUser(userData.id);
                                          },
                                        ),
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
