import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'home_screen.dart';
import 'scan_screen.dart';

class ResultScreen extends StatefulWidget {
  final String imagePath;

  const ResultScreen({super.key, required this.imagePath});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, dynamic> aadhaarDetails = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _processImage();
  }

  String cleanJsonString(String jsonString) {
    jsonString = jsonString.trim();
    if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
      jsonString = jsonString.substring(1, jsonString.length - 1);
    }
    jsonString = jsonString.replaceAll(r'\"', '"').replaceAll(r'\n', '');
    return jsonString;
  }

  Future<void> _processImage() async {
    File imageFile = File(widget.imagePath);
    if (!imageFile.existsSync()) {
      log('File not found: ${widget.imagePath}');
      setState(() {
        isLoading = false;
        errorMessage = 'Image file not found';
      });
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.254.243:8000/extract-aadhaar'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      String extension = imageFile.path.split('.').last.toLowerCase();
      String mimeType = {
        'jpg': 'jpeg',
        'jpeg': 'jpeg',
        'png': 'png',
        'bmp': 'bmp',
        'webp': 'webp'
      }[extension] ?? 'jpeg';

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: MediaType('image', mimeType),
        ),
      );

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      String cleanResponse = cleanJsonString(responseString);
      log('Cleaned JSON Response: "$cleanResponse"');

      if (response.statusCode == 200) {
        try {
          final data = json.decode(cleanResponse);
          if (data is Map<String, dynamic>) {
            setState(() {
              aadhaarDetails = data;
              isLoading = false;
            });
          } else {
            throw Exception('Invalid JSON format');
          }
        } catch (jsonError) {
          log('JSON Parsing Error: $jsonError');
          throw Exception('JSON parsing error: $jsonError');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      log('Processing failed: $e');
      setState(() {
        errorMessage = 'Processing error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00A3E9),
        toolbarHeight: screenHeight * 0.09,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.home_filled, color: Colors.white, size: 26)),
        title: Text(
          'Results',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Aadhaar Image Preview
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              isLoading
                  ? CircularProgressIndicator(color: Color(0xff00A3E9))
                  : errorMessage.isNotEmpty
                  ? Text(
                errorMessage,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05,
                  color: Colors.red,
                ),
              )
                  : _buildDetails(screenWidth),

              SizedBox(height: screenHeight * 0.08),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Details",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00A3E9),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " didn't match ?",
                      style: TextStyle(
                        color: Color(0xff060B2F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              Center(
                child: SizedBox(
                  width: screenWidth * 0.75,
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
                      'Retake Photo',
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
      ),
    );
  }

  Widget _buildDetails(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Color(0xffBEEBFE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Extracted Details',
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
              color: Color(0xff060B2F),
            ),
          ),
          _buildDetailRow('Name', aadhaarDetails['Name'] ?? 'N/A', screenWidth),
          _buildDetailRow('DOB', aadhaarDetails['DOB'] ?? 'N/A', screenWidth),
          _buildDetailRow('Gender', aadhaarDetails['Gender'] ?? 'N/A', screenWidth),
          _buildDetailRow('Aadhaar No.', aadhaarDetails['Aadhaar Number'] ?? 'N/A', screenWidth),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Text('$title: $value', style: GoogleFonts.poppins(fontSize: screenWidth * 0.05)),
    );
  }
}
