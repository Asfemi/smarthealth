import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/services/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  //bool _isSigningIn = false;
  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ValueListenableBuilder(
            valueListenable: userCredential,
            builder: (context, value, child) {
              return (userCredential.value == '' ||
                      userCredential.value == null)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              iconSize: 40,
                              icon: Image.asset(
                                'assets/google_logo.png',
                                height: 50,
                                width: 50,
                              ),
                              onPressed: () async {
                                userCredential.value = await signInWithGoogle();
                                if (userCredential.value != null) {
                                  log(userCredential.value.user!.email);
                                }
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ));
            }));
    //   child: _isSigningIn
    //       ? const CircularProgressIndicator(
    //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //         )
    //       : OutlinedButton(
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all(Colors.white),
    //             shape: MaterialStateProperty.all(
    //               RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(40),
    //               ),
    //             ),
    //           ),
    //           onPressed: () async {
    //             setState(() {
    //               _isSigningIn = true;
    //             });

    // User? user =
    //     await Authentication.signInWithGoogle(context: context);

    //             setState(() {
    //               _isSigningIn = false;
    //             });

    //             // if (user != null) {
    //             //   Navigator.of(context).pushReplacement(
    //             //     MaterialPageRoute(
    //             //       builder: (context) => UserInfoScreen(
    //             //         user: user,
    //             //       ),
    //             //     ),
    //             //   );
    //             // }
    //           },
    //           child: const Padding(
    //             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    //             child: Row(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Image(
    //                   image: AssetImage("assets/google_logo.png"),
    //                   height: 35.0,
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 10),
    //                   child: Text(
    //                     'Sign in with Google',
    //                     style: TextStyle(
    //                       fontSize: 20,
    //                       color: Colors.black54,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    // );
  }
}
