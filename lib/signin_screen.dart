import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recalling_code/constants.dart';
import 'package:recalling_code/home_page.dart';
import 'package:recalling_code/splash_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key}); 

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  TextEditingController _emailTextEditingController = TextEditingController(), _passwordTextEditingController = TextEditingController();
  FocusNode _emailFocus = FocusNode(), _passwordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
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
                txtField(_emailFocus, _emailTextEditingController,'Email Address'),
                txtField(_passwordFocus, _passwordTextEditingController, 'Password',isEmail: false),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(onPressed: checkCredentialsAndLogin,style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder( borderRadius: BorderRadius.circular(10) )), backgroundColor: const WidgetStatePropertyAll(Colors.white)), child: const Text('Sign In',style: TextStyle(color: Colors.black),))),
              ],
            ),
          ),
        ),
      )),
    );
  }

  checkCredentialsAndLogin()
  {
    bool validEmail =  Constants.emailRegex.hasMatch(_emailTextEditingController.text);

      if(!validEmail){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email')));}

    

    else login();
  }

  login()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Widget txtField(FocusNode focus, TextEditingController controller,String hint, {bool isEmail = true})
  {
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 20),
      child: TextField(
          
          style: const TextStyle(color: Colors.white),
          textInputAction: TextInputAction.next,
          obscureText: !isEmail,
          keyboardType: isEmail? TextInputType.emailAddress:TextInputType.visiblePassword,
          cursorColor: Colors.white,
                  decoration:  InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.white,
      
                      focusColor: Colors.white,
                      label: Text(hint, style: TextStyle(color: Colors.white),),
                      hintStyle: const TextStyle(color: Colors.white)),
                  controller: controller,
                  focusNode: focus,
                
      ),
    );
  }
}