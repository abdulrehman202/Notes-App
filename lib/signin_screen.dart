import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recalling_code/constants.dart';
import 'package:recalling_code/db_controller.dart';
import 'package:recalling_code/home_page.dart';
import 'package:recalling_code/signup_screen.dart';
import 'package:recalling_code/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextEditingController = TextEditingController(),
      _passwordTextEditingController = TextEditingController();
  FocusNode _emailFocus = FocusNode(), _passwordFocus = FocusNode();
  DBController _dbController = DBController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  moveToSignUpScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width * .9,
          child: FilledButton(
              onPressed: checkCredentialsAndLogin,
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  backgroundColor: const WidgetStatePropertyAll(Colors.white)),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.black),
              ))),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/image_splashscreen.png',
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Welcome to Notes App',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                txtField(
                    _emailFocus, _emailTextEditingController, 'Email Address'),
                txtField(
                    _passwordFocus, _passwordTextEditingController, 'Password',
                    isEmail: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don' '\'t have an account? ',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: moveToSignUpScreen,
                        child: Text('Register',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)))
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  checkCredentialsAndLogin() {
    bool validEmail =
        Constants.emailRegex.hasMatch(_emailTextEditingController.text);

    if (!validEmail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email')));
    } else
      login();
  }

  login() async {
    try {
      SharedPreferences.setMockInitialValues({});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _emailTextEditingController.text);
      bool loginSuccess = await _dbController.login(
          _emailTextEditingController.text,
          _passwordTextEditingController.text);

      if (loginSuccess) {
        _emailTextEditingController.text = '';
        _passwordTextEditingController.text = '';
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Try Again')));
    }
  }

  Widget txtField(
      FocusNode focus, TextEditingController controller, String hint,
      {bool isEmail = true}) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.next,
        obscureText: !isEmail,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            fillColor: Colors.white,
            focusColor: Colors.white,
            label: Text(
              hint,
              style: TextStyle(color: Colors.white),
            ),
            hintStyle: const TextStyle(color: Colors.white)),
        controller: controller,
        focusNode: focus,
      ),
    );
  }
}
