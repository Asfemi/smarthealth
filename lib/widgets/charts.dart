import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';
import '../helper/utils.dart';
import '../model/liveData.dart';

class Charts extends StatefulWidget {
  const Charts({
    Key? key,
    required this.value,
    required this.index,
    required this.title,
  }) : super(key: key);
  final String value;
  final int index;
  final String title;
  // final Function chartList;

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription _dataStream;
  //late List<LiveData> tempData;
  late int dataStreamValue;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    dataStreamListener();
    dataStreamValue = 0;
    // Utils.getChartData();
    Utils.getBreathingRateChartData();
    Utils.getTemperatureChartData();
    Utils.getOxygenSaturationChartData();
    Utils.getPulseRateChartData();
    chartsList = [
      chartsData1,
      chartsData2,
      chartsData3,
      chartsData4,
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    //_chartSeriesController.
    _dataStream.cancel();
    // TODO: implement activate
    super.deactivate();
  }

  dataStreamListener() {
    _dataStream = database.child(widget.value).onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        dataStreamValue = _data!;
      });
    });
  }

  int time = 1;
  void updateDataSource(Timer timer) {
    if (time != 61) {
      chartsList[widget.index].add(LiveData(time++, dataStreamValue));
      //oxyData.add(LiveData(time++, tempStreamValue));
      chartsList[widget.index].removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: chartsList[widget.index].length - 1,
          removedDataIndex: 0);
    }
    setStateIfMounted(() => time = 1);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  List<LiveData> chartsData1 = Utils.getPulseRateChartData();
  List<LiveData> chartsData2 = Utils.getTemperatureChartData();
  List<LiveData> chartsData3 = Utils.getBreathingRateChartData();
  List<LiveData> chartsData4 = Utils.getOxygenSaturationChartData();

  late List<List<LiveData>> chartsList;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 0.5),
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0.0),
        title: ChartTitle(text: widget.title),
        //legend: Legend(),
        series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartsList[widget.index],
            color: kPrimaryColor,
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
      ),
    );
  }
}
