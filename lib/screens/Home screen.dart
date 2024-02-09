import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/helper/utils.dart';
import 'package:smarthealth/model/homecardData.dart';
import 'package:smarthealth/screens/Settings.dart';
import 'package:smarthealth/screens/chart_details.dart';
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

  List<HomeCardData> cardData = Utils.getHomecardsContents();

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = Utils.getChartContents();

    //String backgroundImage =
    //'assets/national-cancer-institute-701-FJcjLAQ-unsplash.jpg';

    Size size = MediaQuery.sizeOf(context);
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
              'User',
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
                Flexible(
                  child: CircleAvatar(
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
                ),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Best Choices',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cardData.length,
                    //itemExtent: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChartDetailsScreen(
                                          index: index,
                                        )));
                          },
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
                                      padding: const EdgeInsets.all(2),
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
                                      cardData[index].value.toString(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: index == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      cardData[index].name,
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: content.length,
                  itemBuilder: (ctxt, index) {
                    return Card(
                      child: content[index],
                    );
                  }),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
