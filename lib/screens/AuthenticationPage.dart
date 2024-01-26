import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';

import '../widgets/google_sign_in_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);
  static String id = 'authentication';
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/heart-beat.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SmartHealth',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 40,
                      ),
                    ),
                    const Text(
                      'Authentication',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              GoogleSignInButton(),
              // FutureBuilder(
              //   future: Authentication.initializeFirebase(context: context),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return const Text('Error initializing Firebase');
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       return GoogleSignInButton();
              //     }
              //     return CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         CustomColors.firebaseOrange,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
