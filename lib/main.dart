import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/providers/event_provider.dart';
import 'package:bikers_junction_app/providers/route_provider.dart';
import 'package:bikers_junction_app/providers/search_places.dart';
import 'package:bikers_junction_app/providers/user_provider.dart';
import 'package:bikers_junction_app/screens/availableEvent.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/event_chat.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/initiateEmergency.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/router.dart';
import 'package:bikers_junction_app/screens/planRoute.dart';
import 'package:bikers_junction_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EventProvider()),
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const MainEvent()
            : const Login());
  }
}
