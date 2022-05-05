import 'package:smarthealth/constants.dart';
// import 'package:smarthealth/screens/onBoardingPage.dart';
//
// import 'services/Devices.dart';
// import 'screens/Home screen.dart';
// import 'screens/Settings.dart';
// import 'screens/AddDevice.dart';
// import 'screens/Individual%20page.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth/screens/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';

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
            iconTheme: IconThemeData(color: kPrimaryColor),
            color: Colors.deepOrange,
          ),
          primaryColor: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      title: 'SmartHealth',

      home: WelcomePage(),
      // routes: {
      //   //SplashScreen.id: (context) => SplashScreen(),
      //   HomeScreen.id: (context) => const HomeScreen(
      //         pusleRate: '',
      //         temperature: '',
      //         heartRate: '',
      //         bloodPressure: '',
      //       ),
      //   AddDevice.id: (context) => AddDevice(),
      //   Devices.id: (context) => Devices(),
      //   Settings.id: (context) => Settings(),
      //   IndividualPage.id: (context) => IndividualPage(),
      // },
    );
  }
}
