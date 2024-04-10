import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const String routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePass = true;
  bool _obscureConirmPass = true;
  final UserService register = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController birthYear = TextEditingController();
  String? dropDownValue;
  List listItem = ['Event Creator', 'Event Participator'];

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    birthYear.dispose();
  }

  void signupUser() {
    register.signupUser(
        context: context,
        fullname: name.text,
        email: email.text,
        password: password.text,
        role: dropDownValue.toString(),
        dateOfBirth: birthYear.text);
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "New to the app??",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.lato().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    child: SizedBox(
                      width: 350,
                      child: SingleChildScrollView(
                        child: Card(
                          color: const Color.fromARGB(190, 52, 46, 46),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 166),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily,
                                        fontSize: 40),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          label: Text(
                                            "Full Name",
                                            style: TextStyle(
                                                color: Colors.lightGreen,
                                                fontSize: 17),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "field cannot be empty!!!";
                                          } else if (value
                                              .startsWith(RegExp(r'[0-9]'))) {
                                            return "Name cannot starts with number.";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: email,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          label: Text("Email",
                                              style: TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 17)),
                                        ),
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
                                      const SizedBox(height: 5),
                                      TextFormField(
                                        controller: password,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        obscureText: _obscurePass,
                                        decoration: InputDecoration(
                                            label: const Text("Password",
                                                style: TextStyle(
                                                    color: Colors.lightGreen,
                                                    fontSize: 17)),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _obscurePass =
                                                        !_obscurePass;
                                                  });
                                                },
                                                icon: Icon(
                                                    _obscurePass
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: Colors.lightGreen,
                                                    size: 20))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field cannot be empty!!!";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      TextFormField(
                                        controller: confirmPassword,
                                        obscureText: _obscureConirmPass,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            label: const Text(
                                                "Confirm Password",
                                                style: TextStyle(
                                                    color: Colors.lightGreen,
                                                    fontSize: 17)),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureConirmPass =
                                                        !_obscureConirmPass;
                                                  });
                                                },
                                                icon: Icon(
                                                  _obscureConirmPass
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.lightGreen,
                                                  size: 20,
                                                ))),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field cannot be empty!!!";
                                          }
                                          if (password.text != value) {
                                            return "password and confirm-password don't match";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Role:",
                                              style: TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 17)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 100.0),
                                            child: DropdownButton(
                                              dropdownColor:
                                                  const Color.fromARGB(
                                                      255, 60, 68, 51),
                                              style: const TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: 17),
                                              hint: const Text(
                                                "Select your role",
                                                style: TextStyle(
                                                    color: Colors.lightGreen,
                                                    fontSize: 17),
                                              ),
                                              value: dropDownValue,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  dropDownValue =
                                                      newValue.toString();
                                                });
                                              },
                                              items: listItem.map((listItem) {
                                                return DropdownMenuItem(
                                                  value: listItem,
                                                  child: Text(listItem),
                                                );
                                              }).toList(),
                                              icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 150.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            controller: birthYear,
                                            maxLength: 4,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                label: Text("BirthYear (AD)",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.lightGreen,
                                                        fontSize: 17)),
                                                counterText: ""),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Field cannot be empty!!!";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 35.0),
                                            child: InkWell(
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  signupUser();
                                                }
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                    child: Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "Already Registered??",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.lato()
                                                            .fontFamily),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            Login.routeName,
                                                            (route) => false);
                                                  },
                                                  child: const Text(
                                                    "Click here to sign in",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
