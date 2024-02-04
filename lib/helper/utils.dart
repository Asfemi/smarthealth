import 'package:flutter/material.dart';
import 'package:smarthealth/model/homecardData.dart';
import '../widgets/charts.dart';
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

  static List<Widget> getChartContents() {
    return [
      const Charts(
        value: 'input/pulseRate',
        index: 0,
        title: 'PulseRate',
      ),
      const Charts(
        value: 'input/temperature',
        index: 1,
        title: 'Temperature',
      ),
      const Charts(
        value: 'input/breathingRate',
        index: 2,
        title: 'BreathingRate',
      ),
      const Charts(
        value: 'input/oxygenSaturation',
        index: 3,
        title: 'OxygenSaturation',
      ),
    ];
  }

  static List<HomeCardData> getHomecardsContents() {
    return [
      HomeCardData(
        value: 19,
        name: 'PulseRate',
        Path: 'input/pulseRate',
      ),
      HomeCardData(
        value: 32,
        name: 'Temperature',
        Path: "input/temperature",
      ),
      HomeCardData(
        value: 24,
        name: 'BreathingRate',
       Path: 'input/breathingRate',
      ),
      HomeCardData(
        value: 15,
        name: 'Oxygen Saturation',
        Path: 'input/oxygenSaturation',
      ),
    ];
  }

  static List<LiveData> getOxygenSaturationChartData() {
    return <LiveData>[
      LiveData(0, 0),
      LiveData(1, 7),
      LiveData(2, 17),
      LiveData(3, 5),
      LiveData(4, 11),
      LiveData(5, 8),
      LiveData(6, 12),
      LiveData(7, 7),
      LiveData(8, 4),
      LiveData(9, 15),
      LiveData(10, 8),
    ];
  }

  static List<LiveData> getBreathingRateChartData() {
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

  static List<LiveData> getTemperatureChartData() {
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

  static List<LiveData> getPulseRateChartData() {
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
