import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:opinionx/components/custom_helpr.dart';
import 'package:opinionx/database/Apis.dart';
import 'package:opinionx/database/NetworkHandler.dart';
import 'package:opinionx/pages/HomePage.dart';
import 'package:opinionx/utils/constants.dart';

class Otppage extends StatefulWidget {
  final Map<String, String>data;
  const Otppage({super.key, required this.data,});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  Networkhandler networkhandler = Networkhandler();
  TextEditingController _otpController1 = TextEditingController();
  TextEditingController _otpController2 = TextEditingController();
  TextEditingController _otpController3 = TextEditingController();
  TextEditingController _otpController4 = TextEditingController();
  final storage = FlutterSecureStorage();
  bool circular = false;
  String token = "";

  @override
  void initState() {
    super.initState();
    sendOTP();
  }

  void sendOTP() async {
    var response = await networkhandler.post(
        "/user/register/", widget.data);

    if(response["Status"] == "200"){
      token = response["token"];
      log("hello : ${response}");
    }else{
      Dialogs.showSnackbar(context, "Error occured");
    }

  }

  void verifyOTP() async {
    setState(() {
      circular = true;
    });

    String otp = _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text;

    if(otp == ""){
       Dialogs.showSnackbar(context, "Enter OTP");
    }else{
      Map<String, dynamic>yoyo = {
        "otp":otp,
        "auth":widget.data,
      };
      var resss = await networkhandler.post(
          "/user/verifyOtp/", yoyo);
      log("dnejndej   ${resss["Status"]}");
      if(resss["Status"] == "200"){
        // Save user details in local storage
        Map<String, dynamic> mydata = {
          "name": widget.data["name"],
          "email": widget.data["email"],
          "semester": "1",
          "batch": "2028",
          "branch":"IT",
          "imageUrl": "https://tse2.mm.bing.net/th?id=OIP.KfJqjn9jazboxjxZp-4nNAHaJQ&pid=Api&P=0&h=180",
          "token": token,
        };

        String mydataString = jsonEncode(mydata);
        await storage.write(key: 'me', value: mydataString);
        await APIs.myInfo();
          Dialogs.showSnackbar(context, "success");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
          setState(() {
            circular = false;
          });
      }else if(resss["Status"] == "400"){
        Dialogs.showSnackbar(context, "invalid otp");
        setState(() {
          circular = false;
        });
      }else{
        Dialogs.showSnackbar(context, "Error aa gyi");
        setState(() {
          circular = false;
        });
      }

    }
  }

  Widget otpBox(TextEditingController controller, bool autoFocus, BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        autofocus: autoFocus,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '', // Removes the character counter under the box
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus(); // Moves to next box on input
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Verify your Email",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "An OTP has been sent to your email",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                otpBox(_otpController1, true, context),
                otpBox(_otpController2, false, context),
                otpBox(_otpController3, false, context),
                otpBox(_otpController4, false, context),
              ],
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: sendOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.APPCOLOUR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(300, 50), // Button size (width, height)
              ),
              child: Text('Resend OTP', style: TextStyle(fontSize: 20 ,color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.APPCOLOUR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(300, 50), // Button size (width, height)
              ),
              child: circular
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Verify OTP', style: TextStyle(fontSize: 20 , color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
