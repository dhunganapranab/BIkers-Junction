import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Appbar.dart';
import 'package:bikers_junction_app/widgets/Buttons.dart';
import 'package:bikers_junction_app/widgets/Drawer.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "/changePassword";
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.67,
              child: Card(
                color: const Color.fromARGB(118, 99, 96, 68),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Title1(
                            titleName: "Change Your Password", fontSize: 45),
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Title1(
                            titleName: "Old Password",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: oldPass,
                          hintText: " Enter Old Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Title1(
                            titleName: "New Password",
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: newPass,
                          hintText: " Enter New Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty!!!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              CustomButton1(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      userService.changePassword(
                                          context: context,
                                          userID: user.id,
                                          oldPassword: oldPass.text,
                                          newPassword: newPass.text);
                                    }
                                  },
                                  buttonText: const Title1(
                                      titleName: "Confirm Password",
                                      fontSize: 17,
                                      color: Colors.white),
                                  color: const Color.fromARGB(178, 0, 255, 8)),
                              const SizedBox(height: 10),
                              CustomButton1(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  buttonText: const Title1(
                                      titleName: "Back",
                                      fontSize: 17,
                                      color: Colors.white),
                                  color: const Color.fromARGB(177, 255, 51, 0)),
                            ],
                          ),
                        ),
                      ],
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
