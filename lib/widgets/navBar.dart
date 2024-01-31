// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:smarthealth/constants.dart';

BottomNavigationBar CBottomNavigationBar(
  BuildContext context,
  int currentIndex,
  Function(int) onItemTapped,
) {
  return BottomNavigationBar(
    elevation: 0,
    backgroundColor:
        kLightBackgroundColor, //Theme.of(context).scaffoldBackgroundColor,
    //type: BottomNavigationBarType.shifting,
    currentIndex: currentIndex,
    onTap: onItemTapped,
    items: [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: currentIndex != 0 ? '' : 'Home',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: currentIndex != 1 ? '' : 'Settings',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: currentIndex != 2 ? '' : 'Profile',
      ),
    ],
  );
}

SnakeNavigationBar bBottomNavigationBar(
  BuildContext context,
  int currentIndex,
  Function(int) onItemTapped,
) {
  // const BorderRadius _borderRadius = BorderRadius.only(
  //   topLeft: Radius.circular(25),
  //   topRight: Radius.circular(25),
  // );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(35)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(16);

  return SnakeNavigationBar.color(
    height: 70,
    snakeShape: SnakeShape.circle,
    snakeViewColor: Colors.white,
    backgroundColor: Colors.white,
    shape: bottomBarShape,
    behaviour: snakeBarStyle,
    padding: padding,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: false,
    showSelectedLabels: true,
    currentIndex: currentIndex,
    onTap: onItemTapped,
    items: [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: currentIndex != 0 ? '' : 'Home',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        label: currentIndex != 1 ? '' : 'Settings',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: currentIndex != 2 ? '' : 'Profile',
      ),
    ],
  );
}
