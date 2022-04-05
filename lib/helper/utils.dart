import 'package:flutter/material.dart';
import 'package:smarthealth/helper/wifiConnectHelper.dart';

import 'onBoardingHelper.dart';

class Utils {
  static List<OnBoardingContent> getOnBoarding() {
    return [
      OnBoardingContent(
          message: 'Integrate medicine with tech',
          img: 'assets/vecteezy_smart-watch-health-app_.jpg'),
      OnBoardingContent(
          message: 'Get more for your time',
          img: 'assets/4800bd2e61a52c0cf366ffad714dd25c.jpg'),
      OnBoardingContent(
          message: 'seamlessly become more efficient',
          img: 'assets/istockphoto-1225627544-170667a.jpg'),
    ];
  }

  static List<WifiConnectHelper> getWifiConnect() {
    return [
      WifiConnectHelper(
          button: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.deepOrange),
            ),
            onPressed: () {},
            child: const Text('connect'),
          ),
          name: 'device name goes here')
    ];
  }
}
