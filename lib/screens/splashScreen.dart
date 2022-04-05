import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String id = 'start';

  int duration;
  Widget goToPage;

  SplashScreen({
    Key? key,
    required this.goToPage,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => goToPage));
    });

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Image.asset(
              'assets/heart-beat.png',
              height: size.shortestSide * 0.3,
              width: size.shortestSide * 0.3,
            ),
          )),
    );
  }
}
