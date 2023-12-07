import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassMorph extends StatelessWidget {
  final mChild;

  final String? lockedImage;
  final bool isUnlocked;
  final String title;

  GlassMorph({
    required this.mChild,
    required this.isUnlocked,
    required this.lockedImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width * 0.45,
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
              ),
              SizedBox(
                child: isUnlocked
                    ? Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            title,
                            style: GoogleFonts.rubikBubbles(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.black87,
                        ),
                      ),
              ),
            ])));
  }
}
