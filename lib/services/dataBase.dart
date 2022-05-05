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
      'bloodPressure': 115,
      'oxygenSaturation': 16,
      'pulseRate': 22
    });
  }

  //add to init state and deactivate after
  //add late  StreamSubscription _dataListenerStream;
  dataStreamListener() {
    database.child('input/temperature').onValue.listen((event) {
      final double? data = event.snapshot.value as double?;
    });
  }
}
