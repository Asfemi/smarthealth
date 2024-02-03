import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/Homepage.dart';
import 'package:smarthealth/services/authentication.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  //ValueNotifier userCredential = ValueNotifier('');
  

  Widget buildNavigation(BuildContext context) {
    
    return FutureBuilder(
      future: _login(),
      builder: (context, snapshot) {
         
        return const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ));
      },
    );
  }

  Future<String> _login() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return  HomePage();
          },
        ),
      );
    });

    return "Logined";
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context).userCredential;
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ValueListenableBuilder(
            valueListenable: authProvider,
            builder: (context, value, child) {
              return (authProvider.value == '' ||
                      authProvider.value == null)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: InkWell(
                          onTap: () async {
                            authProvider.value = await AuthProvider(). signInWithGoogle();
                            if (authProvider.value != null) {
                              log(authProvider.value.user!.email);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/google_logo.png',
                                height: 50,
                                width: 50,
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
                      ),
                    )
                  : buildNavigation(context);
            }));
  }
}
