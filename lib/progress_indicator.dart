import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_swift/result_screen.dart';

import 'home_screen.dart';

class ProcessingScreen extends StatefulWidget {
  final String imagePath;

  const ProcessingScreen({super.key, required this.imagePath});

  @override
  ProcessingScreenState createState() => ProcessingScreenState();
}

class ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => ResultScreen(imagePath: widget.imagePath)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              child: Image.asset(
                'images/aadhaar.gif',
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            Text(
              'Your Data is being Processed',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.normal,
                color: Color(0xff060B2F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
