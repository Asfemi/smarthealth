import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/helper/utils.dart';
import 'package:smarthealth/model/homecardData.dart';
import 'package:smarthealth/widgets/charts.dart';

class ChartDetailsScreen extends StatefulWidget {
  const ChartDetailsScreen({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;
  @override
  State<ChartDetailsScreen> createState() => _ChartDetailsScreenState();
}

class _ChartDetailsScreenState extends State<ChartDetailsScreen> {
  List<HomeCardData> cardData = Utils.getHomecardsContents();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kLightBackgroundColor,
      appBar: AppBar(
        backgroundColor: kLightBackgroundColor,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(children: [
        SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Text(
                  '4/6',
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.w900),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 80,
                  width: 220,
                  child: Text(
                    'An Average of \nThe ${cardData[widget.index].name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: Card(
                      color: Colors.white,
                      child:
                        Charts(value: cardData[widget.index].Path, index: widget.index, title: cardData[widget.index].name,),
                          //LineChartSample2(value: cardData[widget.index].Path),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: size.height * 0.25,
                    width: size.width,
                    child: const Card(
                      color: Colors.white,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Current:'),
                              trailing: Text('0/min'),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text('Minimum:'),
                              trailing: Text('20/min'),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text('Maximum:'),
                              trailing: Text('10/min'),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text('Average:'),
                              trailing: Text('13/min'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
