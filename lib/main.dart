import 'package:flutter/material.dart';
import 'package:recalling_code/account_screen.dart';
import 'package:recalling_code/signup_screen.dart';
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    TextStyle commonTextStyle = const TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.w500,);
    return MaterialApp( 
      title: 'Splash Screen', 
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff252525),
        floatingActionButtonTheme: const FloatingActionButtonThemeData( shape: CircleBorder(),backgroundColor: Color(0xff252525)),
         primaryColor: const Color(0xff252525),
         appBarTheme: AppBarTheme(color: const Color(0xff252525), titleTextStyle: commonTextStyle.copyWith(fontSize: 20),actionsIconTheme: const IconThemeData(color: Colors.white)),
         iconTheme: const IconThemeData(color: Colors.white),
        textTheme: TextTheme(displayMedium: commonTextStyle,displaySmall: commonTextStyle),
        primarySwatch: Colors.green, 
        filledButtonTheme: const FilledButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff252525))))
      ), 
      home: MyHomePage(), 
      debugShowCheckedModeBanner: false, 
    ); 
  } 
}