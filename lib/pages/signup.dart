import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:opinionx/components/custom_helpr.dart';
import 'package:opinionx/database/Apis.dart';
import 'package:opinionx/pages/HomePage.dart';
import 'package:opinionx/pages/forgotPasswordPage.dart';
import 'package:opinionx/pages/otpPage.dart';
import 'package:opinionx/utils/constants.dart';

import '../database/NetworkHandler.dart';
import '../models/SemViseSubModel.dart';

class Signup extends StatefulWidget {
  final bool isSignin;
  const Signup({super.key, required this.isSignin});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  Networkhandler networkhandler = Networkhandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText = '';
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Form(
                key: _globalkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !widget.isSignin
                          ? "Sign up with email"
                          : "Sign in with email",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !widget.isSignin ? usernameTextField() : Container(),
                    emailTextField(),
                    passwordTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    !widget.isSignin
                        ? ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                circular = true;
                              });
                              await findUser();
                              if (_globalkey.currentState!.validate() &&
                                  validate) {
                                Map<String, String> data = {
                                  "name": _usernameController.text,
                                  "password": _passwordController.text,
                                  "email": _emailController.text
                                };
                                log("${data}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Otppage(
                                              data: data,
                                            )));
                                setState(() {
                                  circular = false;
                                });
                              } else {
                                setState(() {
                                  circular = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Constants.APPCOLOUR, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(300,
                                  50), // Width and height matching the input box
                            ),
                            child: circular
                                ? CircularProgressIndicator(
                                    color: Colors.white) // Spinner color
                                : Text('Sign up',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                circular = true;
                              });
                              checkUser();

                              if(validate) {
                                Dialogs.showSnackbar(context, "login   adadnwnd");
                                login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Constants.APPCOLOUR, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(300,
                                  50), // Width and height matching the input box
                            ),
                            child: circular
                                ? CircularProgressIndicator()
                                : Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                          ),
                    Divider(
                      indent: 40,
                      endIndent: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForgotPasswordPage()));
                          },
                          child: Text(
                            widget.isSignin ? "forget password ?" : "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            widget.isSignin
                                ? setState(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Signup(isSignin: false),
                                      ),
                                    );
                                  })
                                : setState(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Signup(isSignin: true),
                                      ),
                                    );
                                  });
                          },
                          child: Text(
                            widget.isSignin
                                ? "new user?"
                                : "Already Have an Account! Sign In?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))));
  }

  findUser() async {
    if (_emailController.text.isEmpty || !_emailController.text.contains("@iiita.ac.in")) {
      Dialogs.showSnackbar(context, "Invalid Email");
      setState(() {
        validate = false;
        errorText = "email Can't be empty";
        circular = false;
      });
    } else {
      var response =
          await networkhandler.get("/user/find/${_emailController.text}");

      if (response != null) {
        if (response["Status"] != "200") {
          setState(() {
            circular = false;
            validate = false;
            errorText = "email already taken";
          });
        } else {
          setState(() {
            validate = true;
          });
        }
      } else {
        setState(() {
          validate = false;
          errorText = "Invalid response from server";
          circular = false;
        });
      }
    }
  }

  checkUser() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        validate = false;
        errorText = "email Can't be empty";
        circular = false;
      });
    } else {
      var response = await networkhandler
          .get("/user/checkusername/${_emailController.text}");

      if (response != null) {
        if (response["Status"] == "200") {
          setState(() {
            circular = false;
            validate = true;
          });
        } else {
          setState(() {
            validate = false;
          });
        }
      } else {
        setState(() {
          validate = false;
          errorText = "Invalid response from server";
          circular = false;
        });
      }
    }
  }

  login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Dialogs.showSnackbar(context, "enjdende");
      setState(() {
        validate = false;
        errorText = "email and Password can't be empty";
        circular = false;
      });
    } else {
      var response = await networkhandler
          .get("/user/checkusername/${_emailController.text}");

      log("response : ${response}");

      if (response != null) {
        String status = response["Status"];
        log("response $status");

        if (status == "200") {
          log("deen tapak dam dam");
          Map<String, String> data = {
            "email": _emailController.text,
            "password": _passwordController.text.toString(),
          };
          var loginResponse = await networkhandler.post("/user/login/", data);
          if (loginResponse != null) {
            try {
              log("badva : ${loginResponse}");

              if (true) {
                // Check if the response is a Map
                if (loginResponse["Status"] == "200") {

                  var responseData = loginResponse["data"];

                  if (responseData != null) {
                    Map<String, String> mydata = {
                      "name": responseData["name"],
                      "email": responseData["email"],
                      "semester": responseData["semester"].toString(),
                      "batch": responseData["batch"].toString(),
                      "branch": responseData["branch"],
                      "imageUrl": responseData["imageUrl"],
                      "token": responseData["token"],
                    };

                    String mydataString = jsonEncode(mydata);
                    await storage.write(key: 'me', value: mydataString);
                  } else {
                    log("Data field is missing in the response");
                  }
                  await APIs.myInfo();

                  await storage.write(key: "token", value: loginResponse["token"]);
                  setState(() {
                    validate = true;
                    circular = false;
                  });

                  // var help = await networkhandler.get("/help");
                  // Map<String, dynamic> json = help;
                  // SemViseSubject semViseSubject = SemViseSubject.fromJson(json);
                  // log("JSON data: $json");

                  // if (semViseSubject.data != null &&
                  //     semViseSubject.data!.isNotEmpty) {
                  //   Data firstData = semViseSubject.data!.first;
                  //   log("Parsed SemViseSubject: IT-BI: ${firstData.itBi}, ECE: ${firstData.ece}, IT: ${firstData.it}, Year Name: ${firstData.yearName}");
                  // } else {
                  //   log("No data found in SemViseSubject.");
                  // }

                  // if (semViseSubject.status == "200") {
                    await APIs.myInfo();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                        (route) => false);
                  // }
                } else {
                  setState(() {
                    validate = false;
                    errorText = "Password is Incorrect";
                    circular = false;
                  });
                }
              }
            } catch (e) {
              log('Error decoding login response: $e');
              log('Response body: ${loginResponse}');
              setState(() {
                validate = false;
                errorText = "Invalid response from server";
                circular = false;
              });
            }
          } else {
            setState(() {
              validate = false;
              errorText = "Login failed";
              circular = false;
            });
          }
        } else {
          setState(() {
            validate = false;
            errorText = "Username not found";
            circular = false;
          });
        }
      } else {
        setState(() {
          validate = false;
          errorText = "No response from server";
          circular = false;
        });
      }
    }
  }

  Widget usernameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'College Id',
              hintText: 'Enter your College Id', // Adding hint
              fillColor: Colors.white, // Box color
              filled: true,
              enabledBorder: OutlineInputBorder(
                // Black border
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              // errorText: validate ? null : errorText,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) return "email can't be empty";
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email', // Adding label
              hintText: 'Enter your Email', // Adding hint
              fillColor: Colors.white, // Box color
              filled: true,
              enabledBorder: OutlineInputBorder(
                // Black border
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password length must have >=8";
              return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              labelText: 'Password', // Adding label
              hintText: 'Enter your password', // Adding hint
              fillColor: Colors.white, // Box color
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                // Black border
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
