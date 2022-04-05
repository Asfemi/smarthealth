import 'package:flutter/material.dart';
import 'package:smarthealth/constants.dart';

class HomeWidgetRow extends StatelessWidget {
  const HomeWidgetRow({
    required this.ontap,
  });

  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(8),
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
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
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
              child: const Center(
                child: Text(
                  'Ab',
                  style: TextStyle(
                    fontSize: 15,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'data',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'data',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Container(
              height: 15,
              // width: 20,
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(image),
                //   fit: BoxFit.cover,
                // ),
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                color: Colors.green,
                //   boxShadow: [
                //     BoxShadow(
                //       offset: Offset(0, 5),
                //       blurRadius: 10,
                //       color: Colors.teal.withOpacity(0.23),
                //     ),
                //   ],
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    'Safe',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '16.7%',
              style: TextStyle(
                fontSize: 10,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.settings,
              size: 15,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
