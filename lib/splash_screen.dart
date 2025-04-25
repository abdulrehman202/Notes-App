import 'package:flutter/material.dart';

import 'db_controller.dart';
import 'home_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    tryToConnect();
  }

  tryToConnect() async
  {
    try{
    await DBController().connect().then((response){

      switch(response['code']){
        case 200:{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
            break;
            }
        
        case 404:{
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
     content: Text(response['msg']??'Error',),
backgroundColor: Colors.red,
));
        break;}

        default:{
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
     content: Text(response['msg']??'Error'),
backgroundColor: Colors.red,
));
}
        
  }
  });}catch(e)
  {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
     content: Text('There is some problem loading Data.'),
));
  }
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
