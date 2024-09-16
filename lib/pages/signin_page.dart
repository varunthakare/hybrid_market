import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Uncomment or define this if you have the DashboardPage widget somewhere else in your project
// import 'dashboard_page.dart';

class SigninPage extends StatefulWidget {
  final String? mobileNumber; // Accept mobile number

  const SigninPage({super.key, this.mobileNumber}); // Constructor

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool otpVisible = false; // Controls OTP field and Sign-in button visibility
  bool mobileDisabled = false; // Disables mobile input and SEND OTP button
  final TextEditingController mobileController = TextEditingController(); // Mobile input controller
  final TextEditingController otpController = TextEditingController(); // OTP input controller
  String errorMessage = ''; // Displays invalid mobile number error
  bool resendEnabled = false; // Controls resend button state
  int secondsRemaining = 59; // Timer countdown for resend button
  Timer? countdownTimer;
  bool otpSent = false; // New flag to track OTP sent status

  @override
  void initState() {
    super.initState();
    if (widget.mobileNumber != null) {
      mobileController.text = widget.mobileNumber!;
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer?.cancel(); // Cancel the existing timer if any
    setState(() {
      secondsRemaining = 59; // Reset the timer
      resendEnabled = false;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          resendEnabled = true;
          mobileDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  void resetForm() {
    setState(() {
      otpVisible = false;
      mobileDisabled = false;
      errorMessage = '';
      resendEnabled = false;
      secondsRemaining = 59;
      otpSent = false;
      mobileController.clear();
    });
  }

  Future<void> sendOtp(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://localhost:8585/api/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobileno": phoneNumber
      }),
    );

    if (response.statusCode == 200) {
      print("OTP Sent");
      setState(() {
        otpVisible = true; // Show OTP input field
        mobileDisabled = true; // Disable mobile input and SEND OTP button
        startTimer(); // Start the timer for OTP resend
      });
    } else {
      print("Failed to send OTP");
      setState(() {
        errorMessage = "Failed to send OTP"; // Display error message
      });
    }
  }

  Future<void> verify(String phoneno, String otp) async {
    final response = await http.post(
      Uri.parse('http://localhost:8585/api/login/otp-verify'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobileno": phoneno,
        "otp": otp
      }),
    );

    if (response.statusCode == 200) {
      print("Authenticated");
      final responseData = jsonDecode(response.body);

      if (responseData['isNewUser'] == true) {
        // If the user is new, redirect to SignupPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupPage(
              mobileno: phoneno, // Pass the mobile number to SignupPage
            ),
          ),
        );
      } else {
        // If the user is already registered, redirect to DashboardPage (you need to define it)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()), // Ensure DashboardPage is imported or defined
        );
      }
    } else {
      setState(() {
        errorMessage = "Invalid OTP"; // Display error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        resetForm();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/logo.png',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 20),
              const Text(
                'HYBRID MARKET',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 20),
              const Text(
                'WELCOME',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile No.',
                  labelStyle: const TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  errorText: errorMessage.isNotEmpty && !otpVisible ? errorMessage : null,
                ),
                keyboardType: TextInputType.phone,
                enabled: !mobileDisabled,
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: otpVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: otpVisible
                    ? TextField(
                  controller: otpController, // Use the OTP controller
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    errorText: errorMessage.isNotEmpty && otpVisible ? errorMessage : null,
                  ),
                  keyboardType: TextInputType.number,
                )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              mobileDisabled
                  ? ElevatedButton(
                onPressed: resendEnabled
                    ? () {
                  sendOtp(mobileController.text);
                  startTimer(); // Restart timer
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  resendEnabled ? 'RESEND OTP' : 'RESEND OTP ($secondsRemaining)',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  String mobileNumber = mobileController.text.trim();

                  if (mobileNumber.length == 10 && RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
                    setState(() {
                      otpVisible = true;
                      mobileDisabled = true;
                      otpSent = true; // Update OTP sent status
                      errorMessage = '';
                      startTimer(); // Start countdown timer
                      sendOtp(mobileController.text);
                    });
                  } else {
                    setState(() {
                      errorMessage = 'Invalid mobile number';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  otpSent ? 'RESEND OTP' : 'SEND OTP', // Display RESEND OTP if sent
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              AnimatedOpacity(
                opacity: otpVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: otpVisible
                    ? ElevatedButton(
                  onPressed: () {
                    if (otpController.text.length == 6 && RegExp(r'^[0-9]+$').hasMatch(otpController.text)) {
                      verify(mobileController.text, otpController.text);
                    } else {
                      setState(() {
                        errorMessage = "Invalid OTP";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
