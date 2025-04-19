import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AadhaarFormat extends StatelessWidget {
  const AadhaarFormat({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00A3E9),
        toolbarHeight: screenHeight * 0.09,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 34),
        title: Text(
          'Aadhaar Format',
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
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/aadhar_format.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  color: Color(0xff00A3E9), // Blue theme color
                  size: screenWidth * 0.06,
                ),
                SizedBox(width: screenWidth * 0.02), // Space between icon and text
                Expanded(
                  child: Text(
                    'For the best results, ensure your Aadhaar card image meets these guidelines:',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff060B2F),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBulletPoint(
                    Icons.circle_sharp, 'Minimum resolution: 600x400 pixels.', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildBulletPoint(
                    Icons.circle_sharp, 'Clear and well-lit image (avoid shadows or glare).', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildBulletPoint(
                    Icons.circle_sharp, 'All details must be visible and not cropped.', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildBulletPoint(
                    Icons.circle_sharp, 'Blurry or low-quality images may affect accuracy.', screenWidth),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(IconData icon, String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Color(0xff00A3E9),
            size: screenWidth * 0.03,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: const Color(0xff060B2F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
