import 'package:bikers_junction_app/models/event.dart';
import 'package:bikers_junction_app/screens/availableEvent.dart';
import 'package:bikers_junction_app/screens/createEvent.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/eventDetails.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/screens/planRoute.dart';
import 'package:bikers_junction_app/screens/registerScreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Register.routeName:
      return MaterialPageRoute(builder: (_) => const Register());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case Login.routeName:
      return MaterialPageRoute(builder: (_) => const Login());

    case AvailableEvents.routeName:
      return MaterialPageRoute(builder: (_) => const AvailableEvents());

    case CreateEvent.routeName:
      return MaterialPageRoute(builder: (_) => const CreateEvent());

    case EventPage.routeName:
      return MaterialPageRoute(builder: (_) => const EventPage());

    case MainEvent.routeName:
      return MaterialPageRoute(builder: (_) => const MainEvent());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('No available screens!!'),
                ),
              ));
  }
}
