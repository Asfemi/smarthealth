import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';

class Settings extends StatelessWidget {
  static String id = 'settings';
  //const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'settings',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Coing soon'),
          ],
        ),
      ),
    );
  }
}
