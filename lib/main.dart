import 'package:bikers_junction_app/providers/emergency_provider.dart';
import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/providers/route_provider.dart';
import 'package:bikers_junction_app/providers/search_places.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/EventReviews.dart';
import 'package:bikers_junction_app/screens/adminHomePage.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/router.dart';
import 'package:bikers_junction_app/screens/userProfile.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EventProvider()),
    ChangeNotifierProvider(create: (context) => EmergencyProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => RouteDetailProvider()),
    ChangeNotifierProvider<PlaceResultsProvider>(
        create: (context) => PlaceResultsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    userService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bikers Junction',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? (Provider.of<UserProvider>(context).user.role == "_admin"
                ? const AdminHomePage()
                : const HomeScreen())
            : const Login());
  }
}
