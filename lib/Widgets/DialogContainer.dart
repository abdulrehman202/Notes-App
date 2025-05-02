import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  List<Widget> dialogContent;

  DialogContainer({super.key, required this.dialogContent});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: dialogContent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
