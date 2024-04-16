import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/myevents.dart';
import 'package:bikers_junction_app/screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      backgroundColor: const Color.fromARGB(200, 0, 0, 0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            "Biker's Junction",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: GoogleFonts.k2d().fontFamily,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: AssetImage('assets/account.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.black12),
              child: Column(
                children: [
                  Text(
                    user.fullname,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Email: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text(
                        user.email,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    child: const Center(
                      child: Text("Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, UserProfile.routeName, (route) => true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    child: const Center(
                      child: Text("Edit Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyEvents(userID: user.id, role: user.role)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                    child: const Center(
                      child: Text("My Events",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    child: const Center(
                      child: Text("Connect",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
