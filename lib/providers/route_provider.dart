import 'package:bikers_junction_app/models/route_details.dart';
import 'package:flutter/material.dart';

class RouteDetailProvider extends ChangeNotifier {
  RouteDetails _routeDetails = RouteDetails(
    routeName: '',
    startPointCoordinates: '',
    destinationPointCoordinates: '',
  );

  RouteDetails get route => _routeDetails;

  void setRoute(String routeDetails) {
    _routeDetails = RouteDetails.fromJson(routeDetails);
    notifyListeners();
  }
}
