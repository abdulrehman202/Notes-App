import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recalling_code/db_controller.dart';

import 'home_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    DBController.connect().whenComplete((){Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));});
    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
