import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final String instruction;
  final double height;

  SlideTile({
    required this.title,
    required this.imagePath,
    required this.instruction,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.03, horizontal: height * 0.03),
            child: Image.asset(imagePath),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(
              left: height * 0.015,
              right: height * 0.015,
              bottom: kIsWeb
                  ? 70
                  : Platform.isIOS
                      ? 70.0
                      : 60.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.035, horizontal: height * 0.035),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      instruction,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.7),
                        fontSize: 22, //height * 0.025
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
