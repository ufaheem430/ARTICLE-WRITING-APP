import 'package:flutter/material.dart';

class Dividerd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 30),
        Text('OR'),
        SizedBox(width: 30),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
