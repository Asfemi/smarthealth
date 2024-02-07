import 'dart:math';

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
        minimum: '60 beats/min',
        maximum: '220 beats/min',
        average: '70 - 75 beats/min',
      ),
      HomeCardData(
        value: 32,
        name: 'Temperature',
        Path: "input/temperature",
        minimum: '36.1 °C',
        maximum: '> 38 °C',
        average: '36.1 - 37.2 °C',
      ),
      HomeCardData(
        value: 24,
        name: 'BreathingRate',
        Path: 'input/breathingRate',
        minimum: '10 breaths/min',
        maximum: '50 breaths/min',
        average: '12 - 16 breaths/min.',
      ),
      HomeCardData(
        value: 15,
        name: 'Oxygen Saturation',
        Path: 'input/oxygenSaturation',
        minimum: '90% <',
        maximum: '100%',
        average: '97-98%.',
      ),
    ];
  }

  static List<LiveData> getOxygenSaturationChartData() {
    return List.generate(11, (index) {
      return LiveData(index,
          Random().nextInt(6) + 95); // Simulating values between 95% and 100%
    });
  }

  static List<LiveData> getBreathingRateChartData() {
    return List.generate(11, (index) {
      return LiveData(
          index,
          Random().nextInt(10) +
              10); // Simulating values between 10 and 20 breaths per minute
    });
  }

  static List<LiveData> getTemperatureChartData() {
    return List.generate(11, (index) {
      return LiveData(
          index,
          Random().nextInt(2) +
              36.5); // Simulating values between 36.5°C and 38.5°C
    });
  }

  static List<LiveData> getPulseRateChartData() {
    return List.generate(11, (index) {
      return LiveData(
          index,
          Random().nextInt(20) +
              60); // Simulating values between 60 and 80 beats per minute
    });
  }
}
