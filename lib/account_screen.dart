import 'package:flutter/material.dart';
import 'package:recalling_code/signin_screen.dart';
import 'package:recalling_code/signup_screen.dart';

class AccountSelect extends StatefulWidget {
  const AccountSelect({super.key});

  @override
  State<AccountSelect> createState() => _AccountSelectState();
}

class _AccountSelectState extends State<AccountSelect> {
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  moveToLoginScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => SignInScreen()));
  }

  moveToSignUpScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => SignUpScreen()));
  }

  registerButton()
  {
    return  FilledButton(
                      onPressed: moveToSignUpScreen,
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white)),
                      child: const Text(
                        'I am new User',
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
                        'I already have an account',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image_splashscreen.png',
            ),
            Text(
              'Notes App',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  
  }
