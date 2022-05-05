import 'package:flutter/material.dart';
import 'package:smarthealth/helper/wifiConnectHelper.dart';

import '../model/liveData.dart';
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

  static List<LiveData> getTempChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 7),
      LiveData(
        2,
        17,
      ),
      LiveData(
        3,
        5,
      ),
      LiveData(4, 11),
      LiveData(5, 8),
      LiveData(
        6,
        12,
      ),
      LiveData(7, 7),
      LiveData(8, 4),
      LiveData(9, 15),
      LiveData(10, 8),
    ];
  }

  static List<LiveData> getBPChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 4),
      LiveData(2, 7),
      LiveData(3, 1),
      LiveData(4, 5),
      LiveData(5, 8),
      LiveData(6, 3),
      LiveData(7, 17),
      LiveData(8, 4),
      LiveData(9, 15),
      LiveData(10, 8),
    ];
  }

  static List<LiveData> getOYGChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 2),
      LiveData(2, 17),
      LiveData(3, 4),
      LiveData(4, 11),
      LiveData(5, 6),
      LiveData(6, 12),
      LiveData(7, 8),
      LiveData(8, 4),
      LiveData(9, 10),
      LiveData(10, 4),
    ];
  }

  static List<LiveData> getPulseChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 4),
      LiveData(2, 17),
      LiveData(3, 1),
      LiveData(4, 17),
      LiveData(5, 4),
      LiveData(6, 4),
      LiveData(7, 17),
      LiveData(8, 1),
      LiveData(9, 17),
      LiveData(10, 4),
    ];
  }
}
