import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/SemViseSubModel.dart';
import '../models/SpecificSubjectModel.dart';
import '../models/chatuser.dart';

class APIs {
  // static FirebaseAuth auth = FirebaseAuth.instance;
  // static User get user=> auth.currentUser!;                          //google user
  // static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static ChatUser? me;  //my info
  static SemViseSubject? semSubjectName;
  static SpecificSubject? allSubject;                              //no usage
  // static final user_uid = auth.currentUser!.uid;

//--------------FETCH ALL SUBJECTS DATA AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchAllSubjects() async {

  }

//--------------FETCH ALL SUBJECTS Name Based on the Semester AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchSemSubjectName() async{

  }

//-----------------------------Fetch the user data-------------------------------------------------//
  static Future<void> myInfo() async{

  }

//-----------------------------If User Exists Store All the Data From Local Storage to me-------------------//
  static Future<void> offlineInfo() async {

  }

//-----------------------------check user exists-----------------------------------//
  static Future<bool> userExists() async {
     return true;
  }

//-----------------------------create user through google-----------------------------------//
  static Future<void> createGoogleUser() async {

  }

//-----------------------------check user-----------------------------------//
  static Future<void> createUser(String collName, String id, String email, String name) async {

  }

//-----------------------------Signup-----------------------------------//
  static Future<void> signup(String email, String password, String firstname, String lastname) async {

  }

//-----------------------------Sign IN-----------------------------------//
  static Future<void> signin(String email, String password) async {

  }

//-----------------------------Fetch All Semister wise subjects-----------------------------------//
//   static Stream<QuerySnapshot<Map<String, dynamic>>> semViseSubjects() {
//
//   }

//-----------------------------Fetch the user data-------------------------------------------------//
  static Future<void> updateCollegeDetails(int batch , String branch , int semester) async{

  }

//----------------------------Sign Out User From the Application-----------------------------------//
  static Future<void> Signout() async{

  }
}
