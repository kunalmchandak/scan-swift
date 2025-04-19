import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scan_swift/scan_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00A3E9),
        toolbarHeight: screenHeight * 0.09,
        centerTitle: true,
        // leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 34)),
        title: Text(
          'EdgeIDX',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan your',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.11,
                fontWeight: FontWeight.w600,
                color: const Color(0xff060B2F),
              ),
              softWrap: true,
            ),
            Text(
              'Aadhaar',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.12,
                fontWeight: FontWeight.w600,
                color: const Color(0xff00A3E9),
              ),
              softWrap: true,
            ),
            Expanded(
              child: Text(
                'card effortlessly our smart OCR extracts details fast and accurately!',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff060B2F),
                ),
                softWrap: true,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: SizedBox(
                width: screenWidth * 0.70,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScanScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00A3E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Scan Now',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
