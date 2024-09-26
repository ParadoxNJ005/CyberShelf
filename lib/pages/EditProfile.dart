import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opinionx/database/NetworkHandler.dart';
import 'package:opinionx/pages/HomePage.dart';
import '../components/custom_helpr.dart';
import '../database/Apis.dart';
import '../utils/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final semesterController = TextEditingController();
  final branchController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  final Networkhandler networkhandler = Networkhandler();

  String branch = APIs.me!.branch!;
  String curr_year = APIs.me!.batch!;
  String year = "";
  String semester = APIs.me!.semester!;

  List<String> branchItems = ['IT', 'ITBI', 'ECE'];
  List<String> yearItems = ['2023-2027', '2022-2026', '2021-2025', '2024-2028'];
  List<String> semesterItems = ["1", "2", "3", "4", "6", "7", "8"];

  @override
  void initState() {
    super.initState();
    log("${APIs.me!.semester}    ${APIs.me!.batch}");
    year = _getYearFromBatch(curr_year);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    // Initialize controllers with current data
    _initializeControllers();
  }

  @override
  void dispose() {
    semesterController.dispose();
    branchController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _initializeControllers() async {
    String? response = await storage.read(key: 'me');
    log("hihihihi , ${response}");
    if (response != null) {
      Map<String, String> data = jsonDecode(response);
      setState(() {
        branch = APIs.me!.branch!;
        year = _getYearFromBatch(APIs.me!.batch!);
        semester = APIs.me!.semester!;
      });
      // Initialize text controllers with current values
      semesterController.text = APIs.me!.semester!.toString() ?? '';
      branchController.text = APIs.me!.branch ?? '';
    }
  }

  String _getYearFromBatch(String? batch) {
    if (batch == null) return "2022-2026"; // default value
    // Define the logic to return year based on batch
    // For example:
    if (batch == "2028") return "2024-2028";
    if (batch == "2027") return "2023-2027";
    if (batch == "2026") return "2022-2026";
    return "2021-2025";
  }

  String _getBatchFromYear(String? batch) {
    if (batch == null) return "2026"; // default value
    // Define the logic to return year based on batch
    // For example:
    if (batch == "2022-2026") return "2026";
    if (batch == "2024-2028") return "2028";
    if (batch == "2023-2027") return "2027";
    return "2025";
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 120;
    double screenWidth = MediaQuery.of(context).size.width;
    double leftPosition = (screenWidth - containerWidth) / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.APPCOLOUR,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.epilogue(
            textStyle: TextStyle(
              color: Constants.WHITE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/svgIcons/notification.svg",
              color: Constants.WHITE,
            ),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //-----------------------------profile image-----------------------------------//
            Container(
              width: double.infinity,
              height: 200,
              color: Constants.WHITE,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: Constants.APPCOLOUR,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: leftPosition,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Container(
                        width: containerWidth,
                        height: containerWidth,
                        color: Constants.WHITE,
                        child: Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CachedNetworkImage(
                              imageUrl: "https://tse3.mm.bing.net/th?id=OIP.KGWYuU5Ue84EPpiZgsW1QwHaLH&pid=Api&P=0&h=180",
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //-----------------------------Edit Profile button----------------------------//
            Container(
              width: double.infinity,
              height: 40,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 110),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Handle profile picture change
                  },
                  child: Text("Change Picture", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            //---------------------------Enter Fields------------------------------------------------------//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    _buildTextField("Name", APIs.me?.name ?? ''),
                    SizedBox(height: 15),
                    _buildTextField("Email", APIs.me?.email ?? ''),
                    SizedBox(height: 15),
                    _buildDropdown("Branch", branch, branchItems, (newValue) {
                      setState(() {
                        branch = newValue!;
                      });
                    }),
                    SizedBox(height: 15),
                    _buildDropdown("Semester", semester, semesterItems, (newValue) {
                      setState(() {
                        semester = newValue!;
                      });
                    }),
                    SizedBox(height: 15),
                    _buildDropdown("Year", year, yearItems, (newValue) {
                      setState(() {
                        year = newValue!;
                      });
                    }),
                    SizedBox(height: 15),
                    Container(
                      height: 45,
                      width: 180,
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        child: Text("Upload", style: TextStyle(color: Constants.WHITE, fontSize: 20)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Constants.APPCOLOUR),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.black)),
            Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(String label, T value, List<T> items, ValueChanged<T?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.black)),
            DropdownButtonFormField<T>(
              decoration: InputDecoration.collapsed(hintText: ''),
              value: value,
              icon: const Icon(Icons.edit),
              items: items.map((T item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Colors.blue),
        );
      },
    );

    try {
      // String? response = await storage.read(key: 'me');
      // if (response == null) throw Exception('No user data found');

      // Map<String, String> data = jsonDecode(response);

      log("dedjewnfkwndedkwkwnnnnnnnnnnnnnnnnnnnnnnn: ${APIs.me?.email}");
      curr_year = _getBatchFromYear(year);

      Map<String, String> payload = {
        "email": APIs.me?.email ?? '',
        "sem": semester.toString(),
        "branch": branch,
        "year": curr_year.toString(),
        "password": "",
      };

      var result = await networkhandler.post("/user/editProfile", payload);
      log("Update response: ${result}");

      var responseData = result["data"];
      if (responseData != null) {
        Map<String, String> mydata = {
          "name": responseData["name"].toString(),
          "email": responseData["email"].toString(),
          "semester": responseData["semester"].toString(),
          "batch": responseData["batch"].toString(),
          "branch": responseData["branch"].toString(),
          "imageUrl": responseData["imageUrl"].toString(),
        };

        String mydataString = jsonEncode(mydata);
        await storage.delete(key: "me");
        await storage.write(key: 'me', value: mydataString);
      } else {
        log("Data field is missing in the response");
      }
      await APIs.myInfo();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
      );
    } catch (error) {
      Navigator.pop(context);
      Dialogs.showSnackbar(context, "⚠️ Oops! Check Your Internet Connection: ${error}");
    }
  }
}
