import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class IndividualPage extends StatefulWidget {
  //const IndividualPage({Key? key}) : super(key: key);
  static String id = 'individual_Screen';

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

bool test = false;

class _IndividualPageState extends State<IndividualPage> {
  List<_SalesData> data = [
    _SalesData(12.0, 15),
    _SalesData(1.0, 28),
    _SalesData(2.0, 12),
    _SalesData(3.0, 32),
    _SalesData(4.0, 29),
    _SalesData(5.0, 19),
    _SalesData(6.0, 29),
    _SalesData(7.0, 9),
    _SalesData(8.0, 24),
    _SalesData(9.0, 39),
    _SalesData(10.0, 16),
    _SalesData(11.0, 26),
    _SalesData(12.0, 20),
    _SalesData(1.0, 22),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: test
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: () {},
                child: Icon(Icons.add),
              ),
              body: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Graph(
                        size: size,
                        image: 'assets/1.png',
                      ),
                      Text(
                        'Temperature',
                        style: TextStyle(color: Colors.teal),
                      ),
                      SizedBox(height: 20),
                      Graph(
                        size: size,
                        image: 'assets/2.jpg',
                      ),
                      Text(
                        'Heart Rate',
                        style: TextStyle(color: Colors.teal),
                      ),
                      SizedBox(height: 20),
                      Graph(
                        size: size,
                        image: 'assets/3.png',
                      ),
                      Text(
                        'Heart Rate',
                        style: TextStyle(color: Colors.teal),
                      ),
                      SizedBox(height: 20),
                      Graph(
                        size: size,
                        image: 'assets/4.jpg',
                      ),
                      Text(
                        'Heart Rate',
                        style: TextStyle(color: Colors.teal),
                      ),
                      SizedBox(height: 100),
                      //Expanded(child: Container()),
                    ],
                  ),
                ),
              ))
          : Scaffold(
              appBar: AppBar(
                title: const Text('Test charts'),
              ),
              body: Column(children: [
                //Initialize the chart widget
                Container(
                  width: size.shortestSide,
                  height: size.shortestSide,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Health analysis'),
                      // Enable legend
                      //legend: Legend(isVisible: false),
                      // Enable tooltip
                      //tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SalesData, double>>[
                        LineSeries<_SalesData, double>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.time,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: 'health',
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: false))
                      ]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Initialize the spark charts widget
                    child: SfSparkAreaChart.custom(
                      //Enable the trackball
                      // trackball: SparkChartTrackball(
                      //     activationMode: SparkChartActivationMode.tap),
                      //Enable marker
                      // marker: SparkChartMarker(
                      //     displayMode: SparkChartMarkerDisplayMode.all),
                      //Enable data label
                      //labelDisplayMode: SparkChartLabelDisplayMode.all,
                      xValueMapper: (int index) => data[index].time,
                      yValueMapper: (int index) => data[index].sales,
                      dataCount: 13,
                    ),
                  ),
                )
              ])),
    );
  }
}

class _SalesData {
  _SalesData(this.time, this.sales);

  final double time;
  final double sales;
}

class Graph extends StatelessWidget {
  Graph({
    // Key key,
    required this.size,
    required this.image,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.shortestSide - 20,
      height: size.shortestSide / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: Colors.teal.withOpacity(0.23),
          ),
        ],
      ),
      // child: MaterialButton(
      //   onPressed: onPressed,
      // ),
    );
  }
}
