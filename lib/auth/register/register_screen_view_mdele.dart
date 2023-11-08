import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/Model/My_user.dart';
import 'package:flutter_app_to_do/auth/register/register_navigator.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';

/// provider
class RegisterScreenViewModel extends ChangeNotifier {
// todo : hold data - handel logic
  late AuthProvider authProvider;
  late RegisterNavigator navigator;

  void register(String email, String password, String name) async {
//// register
    // todo: show loading
    navigator.showMyLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: name,
        email: email,
      );
      authProvider.updateUser(myUser);
      await FirebaseUtils.addUserToFireStore(myUser);
      // todo: hide loading
      // todo: hide loading
      navigator.hideMyLoading();
      // todo: show message
      navigator.showMessage('Register successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      // todo: hide loading
      navigator.hideMyLoading();
      // todo: show message
      navigator.showMessage(e.toString());
    }
  }
}
