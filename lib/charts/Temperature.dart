import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';
import '../helper/utils.dart';
import '../model/liveData.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({Key? key}) : super(key: key);

  @override
  State<TemperatureChart> createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription _tempStream;
  //late List<LiveData> tempData;
  late int tempStreamValue;
  //late final double textScaleFactor;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateTempDataSource);
    temperatureStreamListener();
    tempStreamValue = 0;
    Utils.getTempChartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    _tempStream.cancel();
    // TODO: implement activate
    super.deactivate();
  }

  temperatureStreamListener() {
    _tempStream = database.child('input/temperature').onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        tempStreamValue = _data!;
      });
    });
  }

  int time = 1;
  void updateTempDataSource(Timer timer) {
    if (time != 61) {
      chartsData.add(LiveData(time++, tempStreamValue));
      //oxyData.add(LiveData(time++, tempStreamValue));
      chartsData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: chartsData.length - 1, removedDataIndex: 0);
    }
    setState(() {
      time = 1;
    });
  }

  List<LiveData> chartsData = Utils.getTempChartData();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 0.5),
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0.0),
        //legend: Legend(),
        series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartsData,
            color: kPrimaryColor,
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
      ),
    );
  }
}
