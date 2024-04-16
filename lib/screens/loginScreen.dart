import 'package:bikers_junction_app/screens/registerScreen.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final UserService login = UserService();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  void logInUser() {
    login.loginUser(
        context: context, email: email.text, password: password.text);
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    "    Welcome To \nBikers Junction!!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: Card(
                      color: const Color.fromARGB(190, 52, 46, 46),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 183),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.lato().fontFamily,
                                    fontSize: 40),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: email,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        label: Text("Email",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 17)),
                                        errorStyle: TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field cannot be empty!!!";
                                      }
                                      if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                          .hasMatch(value)) {
                                        return "Please enter a valid email";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: password,
                                    obscureText: _obscureText,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        label: const Text("Password",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 17,
                                            )),
                                        errorStyle: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: const Color.fromARGB(
                                                  255, 29, 196, 68),
                                              size: 20,
                                            ))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field cannot be empty!!!";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "resetPassword");
                                      },
                                      child: const Text(
                                        "Forgot Password",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 200),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              logInUser();
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
                                                child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          "OR",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 130.0),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            Register.routeName,
                                            (route) => true);
                                      },
                                      child: Text(
                                        "Click here to sign up",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.montserrat()
                                                .fontFamily),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
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
