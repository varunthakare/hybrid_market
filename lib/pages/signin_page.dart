import 'dart:async';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'; // New

class SigninPage extends StatefulWidget {
  final String? mobileNumber;

  const SigninPage({super.key, this.mobileNumber});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool otpVisible = false;
  bool mobileDisabled = false;
  final TextEditingController mobileController = TextEditingController();
  String errorMessage = '';
  bool resendEnabled = false;
  int secondsRemaining = 59;
  Timer? countdownTimer;
  bool otpSent = false;

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
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer?.cancel();
    setState(() {
      secondsRemaining = 59;
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

  // Check Internet Connection before sending OTP
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      setState(() {
        errorMessage = "No internet connection. Please check your network.";
      });
      return false;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    if (await isConnected()) { // Check if connected to the internet
      final response = await http.post(
        Uri.parse('http://192.168.253.200:8080/api/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mobileno": phoneNumber
        }),
      );

      if (response.statusCode == 200) {
        print("OTP Sent");
        setState(() {
          otpVisible = true;
          mobileDisabled = true;
          startTimer();
        });
      } else {
        setState(() {
          errorMessage = "Failed to send OTP";
        });
      }
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
                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                ),
                keyboardType: TextInputType.phone,
                enabled: !mobileDisabled,
              ),
              const SizedBox(height: 20),
              otpVisible
                  ? TextField(
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
                ),
                keyboardType: TextInputType.number,
              )
                  : const SizedBox(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resendEnabled ? () { startTimer(); } : () {
                  String mobileNumber = mobileController.text.trim();
                  if (mobileNumber.length == 10 && RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
                    sendOtp(mobileNumber);
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
                child: Text(otpSent ? 'RESEND OTP' : 'SEND OTP'),
              ),
              const SizedBox(height: 30),
              otpVisible
                  ? ElevatedButton(
                onPressed: () {
                  // Handle OTP verification logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 142),
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
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  resetForm();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
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
