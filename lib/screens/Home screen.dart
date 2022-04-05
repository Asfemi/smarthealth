import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/AddDevice.dart';
import 'package:smarthealth/services/dataBase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import '../services/Devices.dart';
import '../widgets/homeWidgetRow.dart';
//import '../widgets/library_book.dart';
//import 'AddDevice.dart';
import 'Individual%20page.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.temperature,
    required this.heartRate,
    required this.pusleRate,
    required this.bloodPressure,
  });
  static String id = 'home_Screen';

  final String temperature;
  final String heartRate;
  final String pusleRate;
  final String bloodPressure;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
//TODO: refactor the home screen, move methods, and functions into their appropriate places
//the figures on the home page should represent the average of the setup devices

class _HomeScreenState extends State<HomeScreen> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription _tempStream;
  late StreamSubscription _oxygenStream;
  late StreamSubscription _bpStream;
  late StreamSubscription _pulseStream;
  late int tempStreamValue;
  late int oxygenStreamValue;
  late int bpStreamValue;
  late int pulseStreamValue;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
    tempStreamValue = 0;
    oxygenStreamValue = 0;
    bpStreamValue = 0;
    pulseStreamValue = 0;
    //_tempStream.resume();
    temperatureStreamListener();
    bPStreamListener();
    pulseStreamListener();
    oxygenStreamListener();
    chartData = getChartData();
  }

  @override
  deactivate() {
    _tempStream.cancel();
    _oxygenStream.cancel();
    _bpStream.cancel();
    _pulseStream.cancel();
    super.deactivate();
  }
  // chartData = getChartData();

  temperatureStreamListener() {
    _tempStream = database.child('input/temperature').onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        tempStreamValue = _data!;
      });
    });
  }

  bPStreamListener() {
    _bpStream = database.child('input/bloodPressure').onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        bpStreamValue = _data!;
        print('i got here in the bp');
      });
    });
  }

  pulseStreamListener() {
    _pulseStream = database.child('input/pulseRate').onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        pulseStreamValue = _data!;
      });
    });
  }

  oxygenStreamListener() {
    _oxygenStream =
        database.child('input/oxygenSaturation').onValue.listen((event) {
      final int? _data = event.snapshot.value as int?;
      setState(() {
        oxygenStreamValue = _data!;
      });
    });
  }

  int time = 1;
  void updateDataSource(Timer timer) {
    //_tempStreamValue;
    //assert(tempStreamValue == double);
    chartData.add(LiveData(time++, tempStreamValue));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
    ];
  }

  chartLogic() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  // FlutterBlue flutterBlue = FlutterBlue.instance;
                  //
                  // // Start scanning
                  // flutterBlue.startScan(timeout: const Duration(seconds: 4));
                  //
                  // // Listen to scan results
                  // var subscription = flutterBlue.scanResults.listen((results) {
                  //   // do something with scan results
                  //   for (ScanResult r in results) {
                  //     print('${r.device.name} found! rssi: ${r.rssi}');
                  //   }
                  // });
                  //
                  // // Stop scanning
                  // flutterBlue.stopScan();
                  Navigator.pushNamed(context, Devices.id);
                },
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text(
                    'Activity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Add devices',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddDevice()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Notes',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Interests',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text(
                  'Become a member',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'New charts',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Stats',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'About us',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, ArticlesSettingsScreen.id);
                      //TODO: fix this route to the correct one
                    },
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, ArticlesHelpScreen.id);
                      //TODO: fix this route to the correct one
                    },
                    child: Text(
                      'logout',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () async {
            try {
              await DatabaseServices().addDefaultData();
              if (kDebugMode) {
                print('default values has been set');
              }
            } catch (e) {
              if (kDebugMode) {
                print('there is an error! $e');
              }
            }

            //Navigator.pushNamed(context, AddDevice.id);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        //color: Colors.red,
                        height: size.height * 0.10,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Name:'),
                                Text('Id'),
                                Text('Status:'),
                                Text('Last Visit:'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('Mr Ubutu Linux'),
                                Text('xD78Jfebka'),
                                Text('Attention needed!'),
                                Text('15mins ago'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.3,
                      child: Container(
                        //padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(4),
                        height: size.height * 0.3,
                        width: size.shortestSide,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: kPrimaryColor,
                          // ),
                          boxShadow: const [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 4,
                                offset: Offset.zero),
                          ],
                        ),
                        child: HomeCharts(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBox(
                            streamText: 'oxygen saturation',
                            streamValue: oxygenStreamValue,
                            x: 30,
                            ontap: () {},
                          ),
                          StreamBox(
                            streamText: 'blood Pressure',
                            streamValue: bpStreamValue,
                            x: 0,
                            ontap: () {},
                          ),
                          StreamBox(
                            streamText: 'pulse rate',
                            streamValue: pulseStreamValue,
                            x: 30,
                            ontap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('My Devices'),
                    Text('See All'),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.7,
                child: ListView.builder(
                  //add . seperated to the listview plus the
                  //commented out code to use the listview with dividers
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: HomeWidgetRow(
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndividualPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  // separatorBuilder: (context, index) => const Divider(
                  //   indent: 10,
                  //   endIndent: 10,
                  // ),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SfCartesianChart HomeCharts() {
    return SfCartesianChart(
      margin: const EdgeInsets.all(0.0),
      series: <LineSeries<LiveData, int>>[
        LineSeries<LiveData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: chartData,
          color: kPrimaryColor,
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        )
      ],
      // primaryXAxis: NumericAxis(
      //   //desiredIntervals: 2,
      //   // labelsExtent: 5,
      //   // desiredIntervals: 2,
      //   maximumLabelWidth: 1,
      //   majorGridLines: const MajorGridLines(width: 0),
      //   edgeLabelPlacement: EdgeLabelPlacement.shift,
      //   interval: 3,
      //   //title: AxisTitle(text: 'Time (seconds)'),
      // ),
      // primaryYAxis: NumericAxis(
      //   maximumLabelWidth: 1,
      //   axisLine: const AxisLine(width: 0),
      //   interval: 3,
      //   majorTickLines: const MajorTickLines(size: 0),
      //   // title: AxisTitle(text: 'Internet speed (Mbps)'),
      // ),
    );
  }
}

class StreamBox extends StatelessWidget {
  const StreamBox({
    Key? key,
    required this.streamValue,
    required this.streamText,
    required this.x,
    required this.ontap,
  }) : super(key: key);

  final int streamValue;
  final String streamText;
  final double x;
  final VoidCallback ontap;
  //void call back is used where
  // when using nuul safety
  // and you want to return a void function

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 3,
        child: SizedBox(
          height: 70 - x,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$streamValue',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                streamText,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
