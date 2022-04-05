import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/helper/onBoardingHelper.dart';
import 'package:smarthealth/screens/Home%20screen.dart';
import 'package:smarthealth/screens/WelcomePage.dart';
import 'package:smarthealth/widgets/mainAppBar.dart';

import '../helper/utils.dart';
import '../widgets/themeButton.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<OnBoardingContent> _content = Utils.getOnBoarding();
  int pageIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        image: 'assets/200.jpg',
      ),
      body: Container(
        child: Column(
          children: [
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
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.only(
                        left: 40, right: 40, top: 40, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    'assets/heart-beat.png',
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.asset(_content[index].img)),
                              const SizedBox(height: 30),
                              Text(
                                _content[index].message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: index == _content.length - 1,
                            child: ThemeButton(text: 'Finish', onClick: () {})),
                      ],
                    ),
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
                              ? const Color(0xFFC1E09E)
                              : Theme.of(context).canvasColor),
                    ),
                  ),
                ),
              ),
            ),
            ThemeButton(
              text: 'Skip',
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                              temperature: 'temperature',
                              heartRate: 'heartRate',
                              pusleRate: 'pusleRate',
                              bloodPressure: 'bloodPressure',
                            )));
              },
            )
          ],
        ),
      ),
    );
  }
}
