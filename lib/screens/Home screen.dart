import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/Settings.dart';
import 'package:smarthealth/services/authentication.dart';
import 'package:one_clock/one_clock.dart';
import 'ContactUs.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home page';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  late TabController _tabController;
  late PageController _controller;
  int _selectedIndex = 0;

  bool collective = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  deactivate() {
    _controller.dispose();
    _tabController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //final List<Widget> content = Utils.getChartContents();

    //String backgroundImage =
    //'assets/national-cancer-institute-701-FJcjLAQ-unsplash.jpg';

    Size size = MediaQuery.of(context).size;
    //MediaQuery.of(context).
    return Scaffold(
      backgroundColor: collective ? kLightBackgroundColor : Colors.transparent,
      appBar: AppBar(
        backgroundColor: kLightBackgroundColor,
        toolbarHeight: 80.0,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Jocelyn',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Icon(
                  Icons.battery_2_bar,
                  color: Colors.grey,
                  size: 18,
                ),
                Text(
                  '54%',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Card(
            //clipBehavior: Clip.hardEdge,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2))),
            color: Colors.blueGrey,
            child: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  collective = !collective;
                });
                //Navigator.pushNamed(context, Devices.id);
              },
              child: CircleAvatar(
                radius: 12,
                backgroundColor: kPrimaryColor,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.white,
                  child: Container(
                    color: kPrimaryColor,
                    height: 2,
                    width: 2,
                  ),
                ),
              )),
        ],
        bottom: TabBar(
          padding: const EdgeInsets.only(top: 20),
          onTap: (int) {
            _tabController.index = _selectedIndex;
            //_tabController.animateTo(_selectedIndex);
          },
          labelStyle: const TextStyle(color: Colors.white),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
        
          indicatorColor: Colors.transparent,
          dividerColor: kLightBackgroundColor,
          tabs: [
            Tab(
              child: _tabController.index == 0
                  ? Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: const Text(
                        'All',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                  : const Text(
                      'All',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
            Tab(
              child: _tabController.index == 1
                  ? Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: const Text(
                        'Charts',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                  : const Text(
                      'Charts',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
            Tab(
              child: _tabController.index == 2
                  ? Container(
                      decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: const Text(
                        'stats',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                  : const Text(
                      'Stats',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
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
              leading: Icon(
                Icons.home,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ContactUs.id);
                  },
                  child: Text(
                    'contact Us',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AuthProvider().signOutFromGoogle();

                    Navigator.pop(context);
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
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 85,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: AnalogClock(
                      isLive: true,
                      width: 120,
                      height: 120,
                      showDigitalClock: false,
                      datetime: DateTime(2024, 1, 1, 9, 12, 15),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Best Choices',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    //itemExtent: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: index == 0 ? kPrimaryColor : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                            child: SizedBox(
                              height: size.height * 0.2,
                              width: size.width * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.black,
                                    padding: EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.bar_chart,
                                      size: 12,
                                      color: index == 0
                                          ? kPrimaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '16',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: index == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Target',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: index == 0
                                          ? Colors.white70
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(),
          Container(),
        ],
      ),
      // collective
      // ? SizedBox(
      //     height: size.height,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Align(
      //           alignment: Alignment.topLeft,
      //           child: Container(
      //             //color: Colors.red,
      //             height: size.height * 0.09,
      //             padding:
      //                 const EdgeInsets.only(left: 10.0, right: 10.0),
      //             child: const Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text('Name:'),
      //                     Text('Id'),
      //                     Text('Status:'),
      //                     Text('Last Visit:'),
      //                   ],
      //                 ),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      //                     Text('Mr Ubutu Linux'),
      //                     Text('xD78Jfebka'),
      //                     Text('Attention needed!'),
      //                     Text('15mins ago'),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 10),
      //         Expanded(
      //           child: PageView(
      //             controller: _controller,
      //             onPageChanged: (int page) {
      //               setState(() {
      //                 pageIndex = page;
      //               });
      //             },
      //             children: List.generate(
      //               content.length,
      //               (index) => Container(
      //                 height: size.height / 2.5,
      //                 width: size.shortestSide,
      //                 padding: const EdgeInsets.all(10),
      //                 margin: const EdgeInsets.only(
      //                     left: 10, right: 10, top: 40, bottom: 20),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(20),
      //                   boxShadow: [
      //                     BoxShadow(
      //                       color: kPrimaryColor.withOpacity(0.3),
      //                       blurRadius: 20,
      //                       offset: Offset.zero,
      //                     ),
      //                   ],
      //                 ),
      //                 clipBehavior: Clip.hardEdge,
      //                 child: content[index],
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: List.generate(
      //             content.length,
      //             (index) => GestureDetector(
      //               onTap: () {
      //                 _controller.animateTo(
      //                   MediaQuery.of(context).size.width * index,
      //                   duration: const Duration(milliseconds: 500),
      //                   curve: Curves.easeInOut,
      //                 );
      //               },
      //               child: Container(
      //                 width: 20,
      //                 height: 20,
      //                 margin: const EdgeInsets.all(10),
      //                 decoration: BoxDecoration(
      //                   color: kPrimaryColor,
      //                   borderRadius: BorderRadius.circular(50),
      //                   border: Border.all(
      //                       width: 6,
      //                       color: pageIndex == index
      //                           ? kPrimaryColor
      //                           : Theme.of(context).canvasColor),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   )
      // : Container(
      //     color: Colors.transparent,
      //     height: size.height,
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white.withOpacity(0.9),
      //                 borderRadius:
      //                     const BorderRadius.all(Radius.circular(10)),
      //                 border: Border.all(
      //                   color: Colors.yellow,
      //                   width: 2,
      //                 ),
      //               ),
      //               child: const Charts(
      //                 value: 'input/PulseRate',
      //                 index: 0,
      //                 title: 'PulseRate',
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 10),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white.withOpacity(0.9),
      //                 borderRadius:
      //                     const BorderRadius.all(Radius.circular(10)),
      //                 border: Border.all(
      //                   color: Colors.red,
      //                   width: 2,
      //                 ),
      //               ),
      //               child: const Charts(
      //                 value: 'input/Temperature',
      //                 index: 1,
      //                 title: 'Temperature',
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 10),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white.withOpacity(0.9),
      //                 borderRadius:
      //                     const BorderRadius.all(Radius.circular(10)),
      //                 border: Border.all(
      //                   color: Colors.green,
      //                   width: 2,
      //                 ),
      //               ),
      //               child: const Charts(
      //                 value: 'input/breathingRate',
      //                 index: 2,
      //                 title: 'breathingRate',
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 10),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white.withOpacity(0.9),
      //                 borderRadius:
      //                     const BorderRadius.all(Radius.circular(10)),
      //                 border: Border.all(
      //                   color: Colors.blue,
      //                   width: 2,
      //                 ),
      //               ),
      //               child: const Charts(
      //                 value: 'input/oxygenSaturation',
      //                 index: 3,
      //                 title: 'OxygenSaturation',
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
    );

    //hey hey
  }
}
