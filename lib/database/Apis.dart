import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opinionx/database/NetworkHandler.dart';

import '../models/SemViseSubModel.dart';
import '../models/SpecificSubjectModel.dart';
import '../models/chatuser.dart';

class APIs {
  // static FirebaseAuth auth = FirebaseAuth.instance;
  // static User get user=> auth.currentUser!;                          //google user
  // static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static ChatUser? me;  //my info
  static SemViseSubject? semSubjectName;
  static SpecificSubject? allSubject;
  //no usage
  // static final user_uid = auth.currentUser!.uid;

//--------------FETCH ALL SUBJECTS DATA AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchAllSubjects() async {

  }

//--------------FETCH ALL SUBJECTS Name Based on the Semester AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchSemSubjectName() async{

  }

//--------------FETCH ALL SUBJECTS Name Based on the Semester AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchSemViceSubject() async {
    Networkhandler networkhandler = Networkhandler();

    var response = await networkhandler.get("/data/semvisesubject");

    Map<String, dynamic> json = response;

    semSubjectName = SemViseSubject.fromJson(json);
    log("JSON data: $json");

    if (semSubjectName?.data != null && semSubjectName!.data!.isNotEmpty) {
      Data firstData = semSubjectName!.data!.first;
      log("Parsed SemViseSubject: IT-BI: ${firstData.itBi}, ECE: ${firstData.ece}, IT: ${firstData.it}, Year Name: ${firstData.yearName}");

      final storage = FlutterSecureStorage();
      await storage.write(key: 'semSubjectData', value: jsonEncode(semSubjectName!.toJson()));
    } else {
      log("No data found in SemViseSubject.");
    }
  }



//-----------------------------Fetch the user data-------------------------------------------------//
  static Future<void> myInfo() async {
    final storage = FlutterSecureStorage();
    String? response = await storage.read(key: 'me');

    if (response != null) {
      // Decode the JSON string into a Map
      Map<String, dynamic> data = jsonDecode(response);

      // Log the decoded data (optional, for debugging)
      log("Decoded data: $data");

      // Ensure APIs.me is initialized
      if (APIs.me == null) {
        APIs.me = ChatUser(uid: ''); // Initialize with a default UID or handle as needed
      }

      // Safely assign values to APIs.me
      APIs.me?.name = data["name"];
      APIs.me?.email = data["email"];
      APIs.me?.semester = data["semester"];
      APIs.me?.imageUrl = data["imageUrl"];
      APIs.me?.college = "IIITA"; // This is hardcoded as per your original code
      APIs.me?.batch = data["batch"] ;
      APIs.me?.branch = data["branch"];

      log("${APIs.me?.name} ${APIs.me?.email} ${APIs.me?.imageUrl} ${APIs.me?.batch}");
    } else {
      // Handle the case where response is null (optional)
      log("No data found in secure storage.");
    }
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
  static Future<bool> Signout(String? email) async{
      Networkhandler networkhandler = Networkhandler();
      final storage = FlutterSecureStorage();
      var response = await networkhandler.post("/user/signout", {"email" : email});
      if(response["Status"] == "200"){
         await storage.delete(key: "me");
          return true;
      }else{
         log("error occured");
         return false;
      }

  }
}
