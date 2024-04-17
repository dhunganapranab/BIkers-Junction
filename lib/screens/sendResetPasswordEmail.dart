import 'package:bikers_junction_app/services/user_service.dart';
import 'package:bikers_junction_app/widgets/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendResetPasswordEmailScreen extends StatefulWidget {
  static const String routeName = "/sendResetPasswordEmail";
  const SendResetPasswordEmailScreen({super.key});

  @override
  State<SendResetPasswordEmailScreen> createState() =>
      _SendResetPasswordEmailScreenState();
}

class _SendResetPasswordEmailScreenState
    extends State<SendResetPasswordEmailScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg1.png'),
          fit: BoxFit.fill,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, right: 250, left: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Center(
                      child: Row(
                        children: [
                          Text("Back to home",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          SizedBox(width: 5),
                          Icon(
                            Icons.home,
                            color: Colors.white70,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(
                    "Reset Your Password!!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.4,
                    child: Form(
                      key: formKey,
                      child: Card(
                        color: const Color.fromARGB(190, 52, 46, 46),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "We will send you a email for resetting your password. Enter your registered email address below.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.mada().fontFamily),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: email,
                                hintText: " Enter your valid email address..",
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "field cannot be empty!!!";
                                  }

                                  if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 210.0),
                                child: InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      userService.sendResetPasswordEmail(
                                          context: context, email: email.text);
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text("Send email",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
