import 'package:flutter/material.dart';

import '../constants.dart';

class ThemeButton extends StatelessWidget {
  ThemeButton({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final String text;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FlatButton(
        onPressed: onClick,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: kPrimaryColor,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
