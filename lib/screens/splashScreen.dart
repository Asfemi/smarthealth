import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'start';

  int duration;
  Widget goToPage;

  SplashScreen({
    Key? key,
    required this.goToPage,
    required this.duration,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool initialized = false;

  bool error = false;

  //initialize the firebase project using firebaseCore
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    await Firebase.initializeApp();
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      setState(() {
        initialized = true;
        print('initialised');
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        error = true;
        print('error');
      });
    }
  }



  String iconLetter = 'X';

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (error) {
      if (kDebugMode) {
        print('error');
      }
      return somethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!initialized) {
      if (kDebugMode) {
        print('Loading');
      }
      return loading();
    }

    Size size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: widget.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => widget.goToPage));
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

Widget somethingWentWrong() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
            child: Text(
          'Something Went Wrong',
          style: TextStyle(fontSize: 25, color: kPrimaryColor),
        )),
      ),
    ),
  );
}

Widget loading() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontSize: 25,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    ),
  );
}
