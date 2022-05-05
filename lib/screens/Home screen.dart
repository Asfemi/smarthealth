import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:smarthealth/charts/Temperature.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/AddDevice.dart';
import 'package:smarthealth/services/dataBase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:smarthealth/helper/utils.dart';
import 'dart:math' as math;
import '../model/liveData.dart';
import '../services/Devices.dart';
import '../widgets/chartBox.dart';
import '../widgets/chartBuilder.dart';
import '../widgets/homeWidgetRow.dart';
import 'Individual%20page.dart';
import 'package:flutter/material.dart';

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
  late List<LiveData> oxyData;
  late List<LiveData> bpData;
  late List<LiveData> pulseData;
  late ChartSeriesController _chartSeriesController;
  final database = FirebaseDatabase.instance.ref();
  late StreamSubscription _oxygenStream;
  late StreamSubscription _bpStream;
  late StreamSubscription _pulseStream;
  late int oxygenStreamValue;
  late int bpStreamValue;
  late int pulseStreamValue;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateBPDataSource);
    Timer.periodic(const Duration(seconds: 1), updatePulseDataSource);
    Timer.periodic(const Duration(seconds: 1), updateOygDataSource);

    oxygenStreamValue = 0;
    bpStreamValue = 0;
    pulseStreamValue = 0;
    bPStreamListener();
    pulseStreamListener();
    oxygenStreamListener();
    bpData = Utils.getBPChartData();
    pulseData = Utils.getPulseChartData();
    oxyData = Utils.getOYGChartData();
    super.initState();
  }

  @override
  deactivate() {
    _oxygenStream.cancel();
    _bpStream.cancel();
    _pulseStream.cancel();
    super.deactivate();
  }
  // chartData = getChartData();

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
  void updateOygDataSource(Timer timer) {
    if (time != 60) {
      oxyData.add(LiveData(time++, oxygenStreamValue));
      oxyData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: oxyData.length - 1, removedDataIndex: 0);
    }
    setState(() {
      time = 1;
    });
  }

  void updateBPDataSource(Timer timer) {
    if (time != 60) {
      bpData.add(LiveData(time++, bpStreamValue));
      bpData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: bpData.length - 1, removedDataIndex: 0);
    }
    setState(() {
      time = 1;
    });
  }

  void updatePulseDataSource(Timer timer) {
    if (time != 60) {
      pulseData.add(LiveData(time++, pulseStreamValue));
      pulseData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: pulseData.length - 1, removedDataIndex: 0);
    }
    setState(() {
      time = 1;
    });
  }

  //List<LiveData> chartsData = Utils.getTempChartData();

  @override
  Widget build(BuildContext context) {
    SfCartesianChart HomeCharts(List<LiveData> data) {
      return SfCartesianChart(
        margin: const EdgeInsets.all(0.0),
        series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: data,
            color: kPrimaryColor,
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
      );
    }

    Size size = MediaQuery.of(context).size;
    //MediaQuery.of(context).
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
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
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        //color: Colors.red,
                        height: size.height * 0.09,
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
                    // SizedBox(
                    //   height: size.height * 0.3,
                    //   child: Container(
                    //     //padding: const EdgeInsets.all(2),
                    //     margin: const EdgeInsets.all(4),
                    //     height: size.height * 0.3,
                    //     width: size.shortestSide,
                    //     clipBehavior: Clip.hardEdge,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10),
                    //       // border: Border.all(
                    //       //   color: kPrimaryColor,
                    //       // ),
                    //       boxShadow: const [
                    //         BoxShadow(
                    //             color: kPrimaryColor,
                    //             blurRadius: 4,
                    //             offset: Offset.zero),
                    //       ],
                    //     ),
                    //     child: HomeCharts(),
                    //   ),
                    // ),
                    const SizedBox(height: 2),
                    SizedBox(
                      height: size.height / 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //temperature container
                          Container(
                            height: size.shortestSide / 2.3,
                            width: size.shortestSide / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.23),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: const TemperatureChart(),
                          ),
                          //oxygen container
                          Container(
                            height: size.shortestSide / 2.3,
                            width: size.shortestSide / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.23),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: HomeCharts(oxyData),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: size.height / 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //
                          Container(
                            height: size.shortestSide / 2.3,
                            width: size.shortestSide / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.23),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: HomeCharts(bpData),
                          ),
                          //pulse container
                          Container(
                            height: size.shortestSide / 2.3,
                            width: size.shortestSide / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.23),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: HomeCharts(pulseData),
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
}
