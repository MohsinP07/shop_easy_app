// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GradientStrip extends StatelessWidget {
  final Size deviceSize;
  final String title;
  final String imagePath;
  const GradientStrip(
      {super.key,
      required this.deviceSize,
      required this.title,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade300, Colors.teal.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                height: 30,
                width: 60,
                child: Image.asset(
                  fit: BoxFit.contain,
                  imagePath,
                )),
            SizedBox(
              width: deviceSize.width * 0.5 / 100,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
