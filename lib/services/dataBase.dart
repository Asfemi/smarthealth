import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseServices {
  final database = FirebaseDatabase.instance.ref();

  //tests
  addDefaultData() {
    final inputRef = database.child('input/');
    inputRef.update({
      'temperature': 34,
      'breathingRate': 115,
      'oxygenSaturation': 16,
      'pulseRate': 22
    });
  }
}
