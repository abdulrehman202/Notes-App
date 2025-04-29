import 'package:flutter/material.dart';
import 'package:recalling_code/constants.dart';
import 'package:recalling_code/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextEditingController = TextEditingController(),
      _passwordTextEditingController = TextEditingController(),
      _cfmPasswordTextEditingController = TextEditingController();
  FocusNode _emailFocus = FocusNode(),
      _passwordFocus = FocusNode(),
      _cfmPasswordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _cfmPasswordTextEditingController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _cfmPasswordFocus.dispose();
    super.dispose();
  }

  moveToLoginScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => SignInScreen()));
  }

  registerButton()
  {
    return  FilledButton(
                      onPressed: checkCredentialsAndRegister,
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white)),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ));
  }

  signInButton()
  {
    return FilledButton(
                      onPressed: moveToLoginScreen,
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white)),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.black),
                      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width*.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: double.infinity,
                  child:registerButton()),
              SizedBox(
                  width: double.infinity,
                  child: signInButton()),
            ],
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Text(
                'Let\'s get registered!',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 20),
              ),
            ),
            txtField(_emailFocus, _emailTextEditingController, 'Email Address'),
            txtField(_passwordFocus, _passwordTextEditingController, 'Password',
                isEmail: false),
            txtField(_cfmPasswordFocus, _cfmPasswordTextEditingController,
                'Confirm Password',
                isEmail: false),
          ],
        ),
      )),
    );
  }

  checkCredentialsAndRegister() {
    bool validEmail =
        Constants.emailRegex.hasMatch(_emailTextEditingController.text);

    if (!validEmail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Email')));
    } else if (_passwordTextEditingController.text !=
        _cfmPasswordTextEditingController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match')));
    } else
      registerUser();
  }

  registerUser() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('User Registered')));
  }

  Widget txtField(
      FocusNode focus, TextEditingController controller, String hint,
      {bool isEmail = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
