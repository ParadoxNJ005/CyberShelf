import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:opinionx/database/Apis.dart';
import '../components/Custom_navDrawer.dart';
import '../utils/constants.dart';
import 'HomePage.dart';

class Erp extends StatefulWidget {
  const Erp({super.key});

  @override
  State<Erp> createState() => _ErpState();
}

class _ErpState extends State<Erp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Student Portal',
          style: GoogleFonts.epilogue(
            textStyle: TextStyle(
              color: Constants.BLACK,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/svgIcons/hamburger.svg",
            color: Constants.BLACK,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/svgIcons/notification.svg",
              color: Constants.BLACK,
            ),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      drawer: CustomNavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Hello ,",
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "${APIs.erpdata?.name ?? 'User'}", // Provide a fallback
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Constants.BLACK,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 20.0,
                percent: (APIs.erpdata?.cgpa != null ? double.tryParse(
                    APIs.erpdata!.cgpa!)! / 10 : 0),
                center: Text(
                  "CGPA\n${APIs.erpdata?.cgpa ?? 'N/A'}", // Provide a fallback
                  textAlign: TextAlign.center,
                  style: GoogleFonts.epilogue(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Constants.BLACK,
                    ),
                  ),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey[200]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Performance Statistics",
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Constants.BLACK,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _data("1", "${APIs.erpdata?.sem1 ?? 'N/A'}"),
                // Provide a fallback
                _data("2", "${APIs.erpdata?.sem2 ?? 'N/A'}"),
                // Provide a fallback
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _data("3", "${APIs.erpdata?.sem3 ?? 'N/A'}"),
                // Provide a fallback
                _data("4", "${APIs.erpdata?.sem4 ?? 'N/A'}"),
                // Provide a fallback
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _data("5", "${APIs.erpdata?.sem5 ?? 'N/A'}"),
                // Provide a fallback
                _data("6", "${APIs.erpdata?.sem6 ?? 'N/A'}"),
                // Provide a fallback
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _data("7", "${APIs.erpdata?.sem7 ?? 'N/A'}"),
                // Provide a fallback
                _data("8", "${APIs.erpdata?.sem8 ?? 'N/A'}"),
                // Provide a fallback
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _data(String sem, String sgpa) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Text(
                "Semester $sem",
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Constants.BLACK,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "SGPA: $sgpa",
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}