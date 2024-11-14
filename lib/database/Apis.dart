import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:opinionx/database/NetworkHandler.dart';
import 'package:opinionx/models/erpModel.dart';

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
  static Erp? erpdata;

  //no usage
  // static final user_uid = auth.currentUser!.uid;

//--------------FETCH ALL SUBJECTS DATA AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchAllSubjects() async {
    final storage = FlutterSecureStorage();
    Networkhandler networkhandler = Networkhandler();

    try {
      var response = await networkhandler.get("/data/specificsubject");

      Map<String, dynamic> json = response;
      
      SpecificSubject allSubject = SpecificSubject.fromJson(json);
      // log("JSON data: $json");

      if (allSubject.sub != null && allSubject.sub!.isNotEmpty) {
        for (var subjectData in allSubject.sub!) {
          try {
            var encodedSubject = jsonEncode(subjectData.toJson());
            await storage.write(key: subjectData.subjectCode ?? '', value: encodedSubject);
            log("Stored subject: ${subjectData.subjectCode} : $encodedSubject");
          } catch (e) {
            log('Error writing to secure storage for subject ${subjectData.subjectCode}: $e');
          }
        }
      } else {
        log("No data found in Specific Subject.");
      }
    } catch (e) {
      log("fetchAllSubjects Error: $e");
    }
  }


//--------------FETCH ALL SUBJECTS Name Based on the Semester AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchSemSubjectName() async{

  }

//--------------FETCH ALL SUBJECTS Name Based on the Semester AND STORE IT INTO LOCAL STORAGE--------------------------------------------//
  static Future<void> fetchSemViceSubject() async {
    Networkhandler networkhandler = Networkhandler();
    String? keyName = APIs.me!.batch;

    var response = await networkhandler.get("/data/semvisesubject");

    Map<String, dynamic> json = response;

    semSubjectName = SemViseSubject.fromJson(json);
    log("JSON data: $json");

    if (semSubjectName?.data != null && semSubjectName!.data!.isNotEmpty){
      Data firstData = semSubjectName!.data!.first;
      log("Parsed SemViseSubject: IT-BI: ${firstData.itBi}, ECE: ${firstData.ece}, IT: ${firstData.it}, Year Name: ${firstData.yearName}");

      final storage = FlutterSecureStorage();
      await storage.write(key: '${keyName}', value: jsonEncode(semSubjectName!.toJson()));
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
  static Future<void> erpData() async {
    Networkhandler networkhandler = Networkhandler();
    var response = await networkhandler.get("/data/erpData/${APIs.me!.email}");

    final storage = FlutterSecureStorage();
    String? check = await storage.read(key: 'erp');

    if (check != null) {
      log("hi");
      Map<String, dynamic> erpMap = jsonDecode(check);
      APIs.erpdata = Erp.fromJson(erpMap);
    } else {
      log("hello");
      log("Response: $response"); // Log the raw response
      if (response != null && response is Map<String, dynamic>) {
        // Extract the 'data' key
        if (response.containsKey('data')) {
          Map<String, dynamic> data = response['data'];
          APIs.erpdata = Erp.fromJson(data);
          log("Parsed Erp data: ${APIs.erpdata}");
          if (APIs.erpdata != null) {
            log("${APIs.erpdata!.name}"); // Safely log the name
          } else {
            log("Erp data is null after parsing");
          }
        } else {
          log("Response does not contain 'data' key");
        }
      } else {
        print("Invalid response format");
      }
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
