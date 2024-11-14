import 'package:flutter/material.dart';
import 'package:opinionx/pages/Classes.dart';
import 'package:opinionx/pages/CollegeDetails.dart';
import 'package:opinionx/pages/EditProfile.dart';
import 'package:opinionx/pages/HomePage.dart';
import 'package:opinionx/pages/SemViseSubjects.dart';
import 'package:opinionx/pages/SubjectDetails.dart';
import 'package:opinionx/pages/erp.dart';
import 'package:opinionx/pages/otpPage.dart';
import 'package:opinionx/pages/paymentsPage.dart';
import 'package:opinionx/pages/splashscreen.dart';
import 'package:opinionx/utils/constants.dart';
import 'models/SpecificSubjectModel.dart';


void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Constants.SKYBLUE,
        fontFamily: 'Montserrat',
        primaryColor: Constants.DARK_SKYBLUE,
        primaryIconTheme: IconThemeData(color: Colors.white),
        indicatorColor: Constants.WHITE,
        primaryTextTheme: TextTheme(
          headlineMedium: TextStyle(color: Colors.white),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Constants.WHITE,
          labelStyle:
              TextStyle(fontWeight: FontWeight.w600, color: Constants.WHITE),
          unselectedLabelColor: Constants.SKYBLUE,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Constants.SKYBLUE,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: Otppage(email: "naitikjain2005@gmail.com",),
      home: SplashScreen(),
    );
  }
}
