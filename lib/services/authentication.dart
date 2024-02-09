import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



  class AuthProvider extends ChangeNotifier {
  ValueNotifier userCredential = ValueNotifier(null);
   


   Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

        userCredential.value = credential;
        notifyListeners();

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
     
      log('exception->$e');
    }
  }

  
    Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      userCredential.value = null;
      notifyListeners();
      return true;
      
    } on Exception catch (_) {
      return false;
    }
  }
 
}


 