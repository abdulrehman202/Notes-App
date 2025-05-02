import 'package:flutter/material.dart';
import 'DialogContainer.dart';

class ConfirmationDialog extends StatelessWidget {
  String msg;
  VoidCallback yesCB, noCB;

  ConfirmationDialog(
      {super.key, required this.msg, required this.yesCB, required this.noCB});

  Widget _YesNoButton(String txt, VoidCallback doThis, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      height: 50,
      child: TextButton(
          onPressed: doThis,
          child: Text(
            txt,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(dialogContent: [
      Text(msg),
      const SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _YesNoButton(
                'Yes', yesCB, const Color.fromARGB(255, 142, 248, 145)),
          ),
          Expanded(
            child: _YesNoButton(
                'No', noCB, const Color.fromARGB(255, 252, 138, 130)),
          )
        ],
      )
    ]);
  }
}
