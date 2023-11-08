import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/My_user.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
