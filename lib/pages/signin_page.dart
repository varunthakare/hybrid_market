import 'package:flutter/material.dart';
import 'signup_page.dart'; 

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image
            Image.asset(
              'lib/images/logo.png', // Add your logo image here
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            // Hybrid Market Text
            const Text(
              'HYBRID MARKET',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            // Welcome Text
            const Text(
              'WELCOME',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Sign in to continue Text
            const Text(
              'Sign in to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Mobile Number Input Box
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile No.',
                labelStyle: TextStyle(color: Colors.black54), // Set label color here
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            // OTP Input Box
            TextField(
              decoration: InputDecoration(
                labelText: 'OTP',
                labelStyle: TextStyle(color: Colors.black54), // Set label color here
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
            ),
            const SizedBox(height: 30),
            // Sign In Button
            ElevatedButton(
              onPressed: () {
                // Handle sign-in logic here
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Don't have an account? Sign up
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()), // Navigate to SignUpPage
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
}
