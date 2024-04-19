import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      fullname: '',
      email: '',
      password: '',
      role: '',
      dateOfBirth: '',
      token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void clearUser() {
    _user = User(
        id: '',
        fullname: '',
        email: '',
        password: '',
        role: '',
        dateOfBirth: '',
        token: ''); // Or set it to null depending on your implementation
    notifyListeners();
  }
}
