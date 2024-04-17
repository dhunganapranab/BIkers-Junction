import 'package:bikers_junction_app/screens/availableEvent.dart';
import 'package:bikers_junction_app/screens/changePassword.dart';
import 'package:bikers_junction_app/screens/createEvent.dart';
import 'package:bikers_junction_app/screens/event.dart';
import 'package:bikers_junction_app/screens/eventDetails.dart';
import 'package:bikers_junction_app/screens/event_chat.dart';
import 'package:bikers_junction_app/screens/homeScreen.dart';
import 'package:bikers_junction_app/screens/initiateEmergency.dart';
import 'package:bikers_junction_app/screens/loginScreen.dart';
import 'package:bikers_junction_app/screens/memberlist.dart';
import 'package:bikers_junction_app/screens/planRoute.dart';
import 'package:bikers_junction_app/screens/registerScreen.dart';
import 'package:bikers_junction_app/screens/sendResetPasswordEmail.dart';
import 'package:bikers_junction_app/screens/userProfile.dart';
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

    case EventDetails.routeName:
      return MaterialPageRoute(builder: (_) => const EventDetails());

    case MainEvent.routeName:
      return MaterialPageRoute(builder: (_) => const MainEvent());

    case SendResetPasswordEmailScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const SendResetPasswordEmailScreen());

    case PlanRoute.routeName:
      return MaterialPageRoute(builder: (_) => const PlanRoute());

    case UserProfile.routeName:
      return MaterialPageRoute(builder: (_) => const UserProfile());

    case ChangePassword.routeName:
      return MaterialPageRoute(builder: (_) => const ChangePassword());

    case EmergencyDetailsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EmergencyDetailsScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('No available screens!!'),
                ),
              ));
  }
}
