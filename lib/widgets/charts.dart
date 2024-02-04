import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

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

    super.initState();
  }

  @override
  void deactivate() {
    //_chartSeriesController.
    _dataStream.cancel();
    super.deactivate();
  }

  dataStreamListener() {
    _dataStream = database.child(widget.value).onValue.listen((event) {
      final int? data = event.snapshot.value as int?;
      setState(() {
        dataStreamValue = data!;
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
      data: mediaQueryData.copyWith(textScaler: const TextScaler.linear(0.5)),
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

class MyChartPage extends StatefulWidget {
  @override
  _MyChartPageState createState() => _MyChartPageState();
}

class _MyChartPageState extends State<MyChartPage> {
  final database = FirebaseDatabase.instance.ref();
  late DatabaseReference _databaseReference;
  List<FlSpot> chartData = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = database.child('input/pulseRate');

    // Start listening to changes in the Firebase database
    _databaseReference.onValue.listen((event) {
      var data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        updateChartData(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(
            show: false,
            //border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 12,
          lineBarsData: [
            LineChartBarData(
              spots: chartData,
              isCurved: true,
              color: Colors.blue,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  void updateChartData(Map<dynamic, dynamic> data) {
    // Clear existing data
    chartData.clear();

    // Iterate through Firebase data and update the chart
    data.forEach((key, value) {
      chartData.add(FlSpot(double.parse(key), double.parse(value.toString())));
    });

    // Sort the chart data by X values
    chartData.sort((a, b) => a.x.compareTo(b.x));

    // Set state to trigger a rebuild with the updated data
    setState(() {});
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({required this.value});

  final String value;
  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  late ChartSeriesController _chartSeriesController;
  List<Color> gradientColors = [
    kPrimaryColor,
    kDarkBackgroundColor,
  ];

  bool showAvg = false;

  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription _dataStream;
  late double dataStreamValue;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    dataStreamListener();
    dataStreamValue = 0;

    super.initState();
  }

  @override
  void deactivate() {
    _dataStream.cancel();
    super.deactivate();
  }

  dataStreamListener() {
    _dataStream = database.child(widget.value).onValue.listen((event) {
      final double? data = event.snapshot.value as double?;
      setState(() {
        dataStreamValue = data!;
      });
    });
  }

  double time = 1;
  void updateDataSource(Timer timer) {
    if (time != 61) {
      chartsValue.add(FlSpot(time++, dataStreamValue));

      chartsValue.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: chartsValue.length - 1, removedDataIndex: 0);
    }
    setStateIfMounted(() => time = 1);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  late List<FlSpot> chartsValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 12,
              left: 16,
              top: 12,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: kPrimaryColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: kSecondaryColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 2,
            //getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            //getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: 
          //chartsValue,
          const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 2.1),
            FlSpot(8, 5),
            FlSpot(9.5, 1),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
