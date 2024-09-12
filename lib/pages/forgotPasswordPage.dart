import 'package:flutter/material.dart';
import 'package:opinionx/utils/constants.dart';
import 'package:opinionx/database/NetworkHandler.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Networkhandler networkHandler = Networkhandler();
  bool isEmailVerified = false;
  bool isOtpVerified = false;
  bool showOtpFields = true;
  bool showPasswordField = true;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _verifyEmail() async {
    // if (_formKey.currentState!.validate()) {
      var response = await networkHandler.post("/user/sendEmail", {"email": _emailController.text});
      if (response["Status"] == "200") {
        setState(() {
          isEmailVerified = true;
          showOtpFields = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verified. Please enter OTP.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verification failed.')),
        );
      }
    // }
  }

  void _verifyOtp() async {
    String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text;
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit OTP.')),
      );
      return;
    }

    var response = await networkHandler.post("/user/verifyOtp", {"otp": otp, "email": _emailController.text});
    if (response["Status"] == "200") {
      setState(() {
        isOtpVerified = true;
        showPasswordField = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified. Enter new password.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verification failed.')),
      );
    }
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      var response = await networkHandler.post("/user/forgotPassword", {
        "otp": _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text,
        "email": _emailController.text,
        "newPassword": _passwordController.text
      });

      if (response["Status"] == "200") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
        // Navigate to login or home page if necessary
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password update failed.')),
        );
      }
    }
  }

  Widget otpBox(TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
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
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.WHITE,
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black, // Black border
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: isEmailVerified ? null : _verifyEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Verify Email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              if (showOtpFields) ...[
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    otpBox(_otpController1),
                    otpBox(_otpController2),
                    otpBox(_otpController3),
                    otpBox(_otpController4),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Center(
                //   child: SizedBox(
                //     width: double.infinity,
                //     height: 40,
                //     child: ElevatedButton(
                //       onPressed: isOtpVerified ? null : _verifyOtp,
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.blue,
                //         padding: const EdgeInsets.symmetric(horizontal: 30),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //       child: const Text(
                //         'Verify OTP',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
              ],
              if (showPasswordField) ...[
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black, // Black border
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _updatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
