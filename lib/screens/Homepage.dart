import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/Home%20screen.dart';
import 'package:smarthealth/screens/ProfileScreen.dart';
import 'package:smarthealth/screens/SettingsScreen.dart';
import 'package:smarthealth/widgets/navBar.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});

  static String id = 'home page things';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBackgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          SettingsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar:
          bBottomNavigationBar(context, _currentIndex, _onItemTapped),
    );
  }
}
