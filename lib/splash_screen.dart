import 'package:flutter/material.dart';
import 'package:recalling_code/account_screen.dart';

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

  errorMsg(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(days: 365),
      content: SizedBox(
        height: 40,
        child: Row(
          children: [
            Text(
              msg ?? 'Error',
            ),
            TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  tryToConnect();
                },
                child: Text(
                  'Try Again',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 15, color: Colors.black),
                ))
          ],
        ),
      ),
      backgroundColor: Colors.red,
    ));
  }

  tryToConnect() async {
    try {
      await DBController().connect().then((response) {
        switch (response['code']) {
          case 200:
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AccountSelect()));
              break;
            }

          case 404:
            {
              errorMsg(response['msg']);
              break;
            }

          default:
            {
              errorMsg(response['msg']);
            }
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to connect to server'),
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
