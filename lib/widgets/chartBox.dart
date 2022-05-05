import 'package:flutter/material.dart';

import '../constants.dart';


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
  // when using null safety
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
