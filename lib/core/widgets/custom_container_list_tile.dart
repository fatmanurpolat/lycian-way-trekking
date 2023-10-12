import 'package:flutter/material.dart';

Widget customContainerListTile({
  required String text,
}) =>
    Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(0.7), // Kartın arka plan rengi ve opaklık
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Center(
          child: Text(
            "$text",
            style: TextStyle(
              fontSize: 18,
              wordSpacing: 4,
              fontFamily: 'YoungSerif',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
