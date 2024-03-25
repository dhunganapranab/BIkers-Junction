import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final UserService logout = UserService();
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            buttonText: "logout",
            onPressed: () {
              logout.logOut(context);
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 80, top: 8.0),
              child: Text(
                "Hello!! ${user.fullname}. \nWarm welcome to Biker's Junction.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: GoogleFonts.aBeeZee().fontFamily,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                      height: 280,
                      width: 180,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/bike1.png'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20))),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                      height: 270,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Bikers Junction is the place where the thrill of the open road meets the camaraderie of fellow riders. "
                        "Join our vibrant community, embark on exhilarating ride events, and explore the world one journey at a time.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: GoogleFonts.aBeeZee().fontFamily,
                        ),
                      )),
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Here you can join bunch of events or oragnize the riding events"
                  " where you can go for a exciting and adventurous motorbike rides along different places.",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.5,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily),
                )),
            const SizedBox(height: 20),
            Container(
                width: 380,
                height: 270,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(50, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 250,
                          width: 360,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.black],
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/bike2.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                height: 140,
                                width: 360,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Text(
                                  "Join events that intrests you and be a part of exciting moments.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily:
                                          GoogleFonts.aBeeZee().fontFamily),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 195.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'available events');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 46, 255, 21),
                                      minimumSize: const Size(150, 40)),
                                  child: const Text(
                                    "Discover events",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 250,
                          width: 360,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.black],
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/bike3.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                height: 140,
                                width: 360,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Text(
                                  "Organize a event and show your leadership skills with other fellow bikers.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      height: 1.5,
                                      fontFamily:
                                          GoogleFonts.aBeeZee().fontFamily),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 195.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 255, 21),
                                      minimumSize: const Size(150, 40)),
                                  child: const Text(
                                    "Organize event",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
