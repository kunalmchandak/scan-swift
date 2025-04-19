import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_swift/aadhaar_format.dart';
import 'package:scan_swift/progress_indicator.dart';
import 'package:image/image.dart' as img;
import 'package:scan_swift/result_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeCameraFuture;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCameraFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
        if (!status.isGranted) {
          throw Exception('Camera permission denied');
        }
      }

      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        throw Exception('No cameras found');
      }

      _cameraController = CameraController(
        cameras!.first,
        ResolutionPreset.max, // Increase resolution to prevent quality loss
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg, // Ensure high-quality image capture
      );

      await _cameraController!.initialize();

      await _cameraController!.lockCaptureOrientation(DeviceOrientation.portraitUp);

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize camera: $e')),
        );
      }
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera is not initialized')),
      );
      return;
    }

    try {
      final XFile picture = await _cameraController!.takePicture();
      File imageFile = File(picture.path);

      img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());

      if (originalImage != null) {
        int cropWidth = (originalImage.width * 0.9).toInt();  // Crop 90% of width
        int cropHeight = (originalImage.height * 0.3).toInt();  // Crop 30% of height
        int cropX = (originalImage.width - cropWidth) ~/ 2;
        int cropY = (originalImage.height - cropHeight) ~/ 2;

        img.Image croppedImage = img.copyCrop(
          originalImage,
          x: cropX,
          y: cropY,
          width: cropWidth,
          height: cropHeight,
        );

        File croppedFile = File('${imageFile.path}_cropped.png') // Save as PNG
          ..writeAsBytesSync(img.encodePng(croppedImage)); // Use PNG to maintain quality

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProcessingScreen(imagePath: croppedFile.path),
          ),
        );
      } else {
        throw Exception('Failed to process image');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
        iconTheme: const IconThemeData(color: Colors.white, size: 34),
        title: Text(
          'Scan your Card',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Camera Error: ${snapshot.error}'));
          }

          return Stack(
            children: [
              // Full screen camera preview
              Positioned.fill(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
                ),
              ),

              // Overlay: Card frame
              Center(
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Place your card here',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom buttons and info
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.70,
                        height: screenHeight * 0.08,
                        child: ElevatedButton(
                          onPressed: _takePicture,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00A3E9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Take Picture',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.065,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Accepted ',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff060B2F),
                              ),
                            ),
                            TextSpan(
                              text: 'Aadhaar ',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff00A3E9),
                              ),
                            ),
                            TextSpan(
                              text: 'Format',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff060B2F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.70,
                        height: screenHeight * 0.08,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AadhaarFormat()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00A3E9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'View',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.065,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
