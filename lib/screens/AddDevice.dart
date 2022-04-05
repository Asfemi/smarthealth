import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/wifiIotScreen.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({Key? key}) : super(key: key);

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  bool on = false;

  buttonUpdater() {
    setState(() {
      on = !on;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Device'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white60,
                    kPrimaryColor,
                  ], end: Alignment.bottomLeft, begin: Alignment.topRight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Use wifi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        buttonUpdater();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.deepOrange),
                      ),
                      child: Text(on ? 'No' : 'Off'),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('wifi networks'),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.zero,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.23),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Saved Network'),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.zero,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.23),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => FlutterWifiIoT()));
                },
                icon: const Icon(
                  Icons.wifi,
                  color: kPrimaryColor,
                ),
              ),
              //const Text('saved networks'),
              //Container(),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
//
// class AddDevice extends StatefulWidget {
//   static String id = 'adddevice';
//   final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
//   final String title = 'Add a blue device';
//   final FlutterBlue flutterBlue = FlutterBlue.instance;
//   final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
//
//   @override
//   _AddDeviceState createState() => _AddDeviceState();
// }
//
// class _AddDeviceState extends State<AddDevice> {
//   final _writeController = TextEditingController();
//   late BluetoothDevice _connectedDevice;
//   late List<BluetoothService> _services;
//
//   //to turn on bluetooth
//   _onBlue(FlutterBlue flutterBlue) {
//     // Start scanning
//     flutterBlue.startScan(timeout: Duration(seconds: 4));
//
//     // // Listen to scan results
//     // var subscription = flutterBlue.scanResults.listen((results) {
//     //   // do something with scan results
//     //   for (ScanResult r in results) {
//     //     print('${r.device.name} found! rssi: ${r.rssi}');
//     //   }
//     // });
//
// // Stop scanning
//     flutterBlue.stopScan();
//   }
//
// //to search for bluetooth devices
//   _addDeviceTolist(final BluetoothDevice device) {
//     if (!widget.devicesList.contains(device)) {
//       setState(() {
//         widget.devicesList.add(device);
//       });
//     }
//   }
//
//   //to also show connected devices
//   @override
//   void initState() {
//     super.initState();
//     // _onBlue(widget.flutterBlue);
//     widget.flutterBlue.connectedDevices
//         .asStream()
//         .listen((List<BluetoothDevice> devices) {
//       for (BluetoothDevice device in devices) {
//         _addDeviceTolist(device);
//       }
//     });
//     widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
//       for (ScanResult result in results) {
//         _addDeviceTolist(result.device);
//       }
//     });
//     widget.flutterBlue.startScan();
//   }
//
//   ListView _buildListViewOfDevices() {
//     List<Container> containers = <Container>[];
//     for (BluetoothDevice device in widget.devicesList) {
//       containers.add(
//         Container(
//           height: 50,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   children: <Widget>[
//                     Text(device.name == '' ? '(unknown device)' : device.name),
//                     Text(device.id.toString()),
//                   ],
//                 ),
//               ),
//               FlatButton(
//                 color: Colors.teal,
//                 child: Text(
//                   'Connect',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   setState(() async {
//                     widget.flutterBlue.stopScan();
//                     try {
//                       await device.connect();
//                     } catch (e) {
//                       var code;
//                       if (e.toString() != 'already_connected') {
//                         throw e;
//                       }
//                     } finally {
//                       _services = await device.discoverServices();
//                     }
//                     _connectedDevice = device;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ...containers,
//       ],
//     );
//   }
//
//   ListView _buildConnectDeviceView() {
//     List<Container> containers = <Container>[];
//
//     for (BluetoothService service in _services) {
//       List<Widget> characteristicsWidget = <Widget>[];
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         characteristic.value.listen((value) {
//           print(value);
//         });
//         characteristicsWidget.add(
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Text(characteristic.uuid.toString(),
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     ..._buildReadWriteNotifyButton(characteristic),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Text('Value: ' +
//                         widget.readValues[characteristic.uuid].toString()),
//                   ],
//                 ),
//                 Divider(),
//               ],
//             ),
//           ),
//         );
//       }
//       containers.add(
//         Container(
//           child: ExpansionTile(
//               title: Text(service.uuid.toString()),
//               children: characteristicsWidget),
//         ),
//       );
//     }
//
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         ...containers,
//       ],
//     );
//   }
//
//   List<ButtonTheme> _buildReadWriteNotifyButton(
//       BluetoothCharacteristic characteristic) {
//     List<ButtonTheme> buttons = <ButtonTheme>[];
//
//     if (characteristic.properties.read) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: RaisedButton(
//               color: Colors.blue,
//               child: Text('READ', style: TextStyle(color: Colors.white)),
//               onPressed: () async {
//                 var sub = characteristic.value.listen((value) {
//                   setState(() {
//                     widget.readValues[characteristic.uuid] = value;
//                   });
//                 });
//                 await characteristic.read();
//                 sub.cancel();
//               },
//             ),
//           ),
//         ),
//       );
//     }
//     if (characteristic.properties.write) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: RaisedButton(
//               child: Text('WRITE', style: TextStyle(color: Colors.white)),
//               onPressed: () async {
//                 await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Write"),
//                         content: Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: TextField(
//                                 controller: _writeController,
//                               ),
//                             ),
//                           ],
//                         ),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text("Send"),
//                             onPressed: () {
//                               characteristic.write(
//                                   utf8.encode(_writeController.value.text));
//                               Navigator.pop(context);
//                             },
//                           ),
//                           FlatButton(
//                             child: Text("Cancel"),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       );
//                     });
//               },
//             ),
//           ),
//         ),
//       );
//     }
//     if (characteristic.properties.notify) {
//       buttons.add(
//         ButtonTheme(
//           minWidth: 10,
//           height: 20,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: RaisedButton(
//               child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
//               onPressed: () async {
//                 characteristic.value.listen((value) {
//                   widget.readValues[characteristic.uuid] = value;
//                 });
//                 await characteristic.setNotifyValue(true);
//               },
//             ),
//           ),
//         ),
//       );
//     }
//
//     return buttons;
//   }
//
//   ListView _buildView() {
//     if (_connectedDevice != null) {
//       return _buildConnectDeviceView();
//     }
//     return _buildListViewOfDevices();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: _buildView(),
//       );
// }
