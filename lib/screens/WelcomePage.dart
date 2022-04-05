import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth/screens/onBoardingPage.dart';

import '../constants.dart';
import '../widgets/themeButton.dart';
import 'Home screen.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //const WelcomePage({Key? key}) : super(key: key);
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

  String backgroundImage =
      'assets/national-cancer-institute-701-FJcjLAQ-unsplash.jpg';

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

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            //background image
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //major  content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // major icon
                  const SizedBox(height: 50),
                  Center(
                    child: ClipOval(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        height: 180,
                        width: 180,
                        child: Image.asset(
                          'assets/heart-beat.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  //project name
                  const Text(
                    'Smart Health',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  //welcome text
                  const Text(
                    'Welcome muchacho. \nyour arrival has been much expected',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  //Sign up button
                  ThemeButton(
                    text: 'SignUp',
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingPage()));
                    },
                  ),
                  //Login button
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          splashColor: kPrimaryColor.withOpacity(0.2),
                          highlightColor: kPrimaryColor.withOpacity(0.2),
                          child: Container(
                            child: const Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //anonymous sign in button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen(
                                      pusleRate: '',
                                      temperature: '',
                                      heartRate: '',
                                      bloodPressure: '',
                                    )));
                      },
                      child: Text(
                        'Sign in Anonymously',
                        style: TextStyle(
                          fontSize: 16,
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
        child: Center(
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
