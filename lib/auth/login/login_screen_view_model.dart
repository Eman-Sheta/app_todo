import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/auth/login/login_navigator.dart';
import 'package:flutter_app_to_do/firebase_utils.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  // hold data - handle logic
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;
  late LoginNavigator navigator;

  void login() async {
    //// login
    if (formKey.currentState!.validate() == true) {
      navigator.showMyLoading();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        authProvider.updateUser(user);
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMessage('Login successfully');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMessage('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo: hide loading
          navigator.hideMyLoading();
          // todo: show message
          navigator.showMessage('Wrong password provided for that user.');
        }
      } catch (e) {
        // todo: hide loading
        navigator.hideMyLoading();
        // todo: show message
        navigator.showMessage(e.toString());
      }
    }
  }
}
