import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';

Widget customElevatedButton(
        {required Function() onPressed,
        required String buttonText,
        Color? buttonColor}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? CustomColors.DEEPRED,
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(buttonText),
    );
