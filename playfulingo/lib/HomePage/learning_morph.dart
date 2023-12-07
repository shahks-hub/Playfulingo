import 'dart:ui';
import 'package:flutter/material.dart';

class LearnMorph extends StatelessWidget {
  final mChild;

  LearnMorph({
    required this.mChild,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(children: [
              BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container()),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.red.withOpacity(0.2)
                        ])),
              ),
              Center(
                child: SingleChildScrollView(
                  child: mChild,
                ),
              )
            ])));
  }
}
