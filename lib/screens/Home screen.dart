import 'dart:ui';

import 'package:smarthealth/constants.dart';
import 'package:smarthealth/helper/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/charts.dart';
import 'ContactUs.dart';
import 'Settings.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
//TODO: refactor the home screen, move methods, and functions into their appropriate places
//the figures on the home page should represent the average of the setup devices

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  late PageController _controller;

  bool collective = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _content = Utils.getChartContents();

    String backgroundImage =
        'assets/national-cancer-institute-701-FJcjLAQ-unsplash.jpg';

    Size size = MediaQuery.of(context).size;
    //MediaQuery.of(context).
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: collective ? Colors.white : Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text('Home'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        collective = !collective;
                      });
                      //Navigator.pushNamed(context, Devices.id);
                    },
                    child: Icon(
                      collective ? Icons.view_agenda : Icons.view_carousel,
                      color: kPrimaryColor,
                    )),
              ],
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
                      Navigator.pushNamed(context, Settings.id);
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
                          //Navigator.pushNamed(context, ArticlesHelpScreen.id);
                          //TODO: fix this route to the correct one
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
            body: collective
                ? SizedBox(
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            //color: Colors.red,
                            height: size.height * 0.09,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
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
                        const SizedBox(height: 10),
                        Expanded(
                          child: PageView(
                            controller: _controller,
                            onPageChanged: (int page) {
                              setState(() {
                                pageIndex = page;
                              });
                            },
                            children: List.generate(
                              _content.length,
                              (index) => Container(
                                height: size.height / 2.5,
                                width: size.shortestSide,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 40, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kPrimaryColor.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: Offset.zero,
                                    ),
                                  ],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: _content[index],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _content.length,
                            (index) => GestureDetector(
                              onTap: () {
                                _controller.animateTo(
                                  MediaQuery.of(context).size.width * index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 6,
                                      color: pageIndex == index
                                          ? kPrimaryColor.shade100
                                          : Theme.of(context).canvasColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 2,
                                ),
                              ),
                              child: const Charts(
                                value: 'input/PulseRate',
                                index: 0,
                                title: 'PulseRate',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              child: const Charts(
                                value: 'input/Temperature',
                                index: 1,
                                title: 'Temperature',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                              child: const Charts(
                                value: 'input/breathingRate',
                                index: 2,
                                title: 'breathingRate',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: const Charts(
                                value: 'input/oxygenSaturation',
                                index: 3,
                                title: 'OxygenSaturation',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],

        //hey hey
      ),
    );
  }
}
