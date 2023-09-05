import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';

Widget customCard(
        {backgrounColor,
        required String title,
        required value,
        required onTap,
        color}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Kartın genişliği tam ekran genişliği
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color ?? CustomColors.BLUE_GRADIANT_END,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
