import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/auth/Dialog_utils.dart';
import 'package:flutter_app_to_do/auth/login/login_navigator.dart';
import 'package:flutter_app_to_do/auth/login/login_screen_view_model.dart';
import 'package:flutter_app_to_do/auth/register/register_screen.dart';
import 'package:flutter_app_to_do/componenet/custom_text_form_field.dart';
import 'package:flutter_app_to_do/home_screen.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    viewModel.authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/main_background.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Form(
                key: viewModel.formKey,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          CustomTextFormField(
                            label: 'Email Addrress',
                            keyboardType: TextInputType.emailAddress,
                            controller: viewModel.emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter email address';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(text);
                              if (!emailValid) {
                                return 'Please enter valid  email';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            label: 'Password',
                            keyboardType: TextInputType.number,
                            controller: viewModel.passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter Password';
                              }
                              if (text.length < 6) {
                                return 'Password should be at least 6 chars';
                              }
                              return null;
                            },
                            isPassword: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.login();
                              },
                              child: Text(
                                'login',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Text(
                                "Don't have an account ?",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      RegisterScreen.routeName);
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    DialogUtils.showMessage(context, message, posActionName: 'Ok',
        posAction: () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  void showMyLoading() {
    // TODO: implement showMyLoading
    DialogUtils.showLoading(context, 'loading...');
  }
}
