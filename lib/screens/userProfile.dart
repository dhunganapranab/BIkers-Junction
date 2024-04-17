import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/changePassword.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const String routeName = "/userProfile";
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  UserService userService = UserService();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController birthYear;
  String selectedYear = "2002";

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    name = TextEditingController(text: user.fullname);
    email = TextEditingController(text: user.email);
    birthYear = TextEditingController(text: user.dateOfBirth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg5.jpg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white30),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage('assets/account.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "user-id: ${user.id.substring(0, 7)}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Title1(
                            titleName: "FullName",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: name,
                          hintText: " Enter your full name..",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Title1(
                            titleName: "Email",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: email,
                          hintText: " Enter your Email..",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Title1(
                            titleName: "Birth year (AD)",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          width: 150,
                          controller: birthYear,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          hintText: " Birth year (AD)",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                        ),
                        CustomButton1(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userService.updateProfile(
                                    context: context,
                                    userID: user.id,
                                    name: name.text,
                                    email: email.text,
                                    dob: birthYear.text);
                              }
                            },
                            buttonText: const Title1(
                                titleName: "Update Profile",
                                fontSize: 17,
                                color: Colors.white),
                            color: const Color.fromARGB(178, 0, 255, 8)),
                        CustomButton1(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  ChangePassword.routeName, (route) => true);
                            },
                            buttonText: const Title1(
                                titleName: "Click here to change Password",
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            color: const Color.fromARGB(143, 255, 174, 0)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
