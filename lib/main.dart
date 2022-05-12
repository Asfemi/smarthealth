import 'package:smarthealth/constants.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth/screens/ContactUs.dart';
import 'package:smarthealth/screens/Home%20screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smarthealth/screens/Settings.dart';
import 'package:smarthealth/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //TODO: get the appropriate  icon size for the splash screen
  // and set them within the mipmap folders in android/app/main/src/mipmap
  @override
  Widget build(BuildContext context) {
    //final theme = AcademiaTheme.dark();
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: kPrimaryColor),
            // color: Colors.white,
          ),
          primaryColor: kPrimaryColor),
      debugShowCheckedModeBanner: false,
      title: 'SmartHealth',
      home: SplashScreen(
        goToPage: HomeScreen(),
        duration: 2,
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        Settings.id: (context) => Settings(),
        ContactUs.id: (context) => ContactUs(),
      },
    );
  }
}
