import 'package:bikers_junction_app/models/emergency.dart';
import 'package:flutter/material.dart';

class EmergencyProvider extends ChangeNotifier {
  Emergency _emergency = Emergency(
    id: '',
    eventID: '',
    userName: '',
    userID: '',
    userLocation: '',
    message: '',
    time: '',
  );

  Emergency get emergency => _emergency;

  void setEmergency(String emergency) {
    _emergency = Emergency.fromJson(emergency);
    notifyListeners();
  }
}
