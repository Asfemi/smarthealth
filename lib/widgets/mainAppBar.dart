import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({
    Key? key,
    this.themeColor = kPrimaryColor,
    required this.image,
  }) : super(key: key);

  Color themeColor;
  String image;

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backwardsCompatibility: false,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: widget.themeColor),
      backgroundColor: Colors.transparent,
      title: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        height: 30,
        width: 30,
        child: Image.asset(
          'assets/heart-beat.png',
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          child: ClipOval(
            child: Container(
                height: 100,
                width: 45,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.fill,
                )),
          ),
        )
      ],
    );
  }
}
