import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG support
import 'package:google_fonts/google_fonts.dart';
import 'package:opinionx/pages/HomePage.dart';
import 'package:opinionx/utils/constants.dart';
/*
after this page there should be 3 landing pages if the user is not logged int
or lese it should direct to the homesreen
 */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // Hide status bar

    // Navigate after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      _navigateToNextScreen();
    });
  }

  Future<void> _navigateToNextScreen() async {
    final storage = new FlutterSecureStorage();
    final temp = await storage.read(key: "me");
    log("${temp}");
    //
    if (temp != null) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.APPCOLOUR,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgIcons/applogo.svg', // Replace with your SVG file path
                height: 100, // Adjust height as needed
                width: 100, // Adjust width as needed
              ),
              SizedBox(height: 20,),
              Text(
                'Cyber Shelf 📚',
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontSize: 40,
                    color: Constants.WHITE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}