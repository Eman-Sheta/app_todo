import 'package:flutter/material.dart';
import 'package:flutter_app_to_do/auth/Dialog_utils.dart';
import 'package:flutter_app_to_do/auth/login/login_screen.dart';
import 'package:flutter_app_to_do/auth/register/register_navigator.dart';
import 'package:flutter_app_to_do/auth/register/register_screen_view_mdele.dart';
import 'package:flutter_app_to_do/componenet/custom_text_form_field.dart';
import 'package:flutter_app_to_do/home_screen.dart';
import 'package:flutter_app_to_do/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

//// View
class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmationPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

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
                key: formKey,
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
                            label: 'User Name',
                            controller: nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter user name';
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            label: 'Email Addrress',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                            controller: passwordController,
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
                          CustomTextFormField(
                            label: 'Confirmation Password',
                            keyboardType: TextInputType.number,
                            controller: confirmationPasswordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please enter Confirmation Password';
                              }
                              if (text != passwordController.text) {
                                return "Password doesn't match.";
                              }
                              return null;
                            },
                            isPassword: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              child: Text(
                                'Register',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text('Already have an account'),
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(
          emailController.text, passwordController.text, nameController.text);
    }
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
