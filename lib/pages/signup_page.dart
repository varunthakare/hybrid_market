import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import the SignInPage

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedRole = 'Farmer'; // Default value for the dropdown
  final TextEditingController nameController = TextEditingController(); // Name input controller
  final TextEditingController mobileController = TextEditingController(); // Mobile input controller
  String nameErrorMessage = ''; // Error message for Name field
  String mobileErrorMessage = ''; // Error message for Mobile Number field

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
              height: 50,
              width: 50,
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
            // Sign up to continue Text
            const Text(
              'Sign up to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Name Input Box
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.black54), // Set label color here
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(0),
                ),
                errorText: nameErrorMessage.isNotEmpty ? nameErrorMessage : null, // Show error for Name
              ),
            ),
            const SizedBox(height: 20),
            // Mobile Number Input Box
            TextField(
              controller: mobileController,
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
                errorText: mobileErrorMessage.isNotEmpty ? mobileErrorMessage : null, // Show error for Mobile
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            // Dropdown List
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'I am a...',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              items: <String>['Farmer', 'Consumer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                String mobileNumber = mobileController.text.trim();

                // Validate Name and Mobile Number
                setState(() {
                  nameErrorMessage = name.isEmpty ? 'Name is required' : '';
                  mobileErrorMessage = mobileNumber.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobileNumber)
                      ? 'Invalid mobile number'
                      : '';
                });

                if (nameErrorMessage.isEmpty && mobileErrorMessage.isEmpty) {
                  // Clear error message and navigate to SignInPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(mobileNumber: mobileNumber),
                    ), // Pass mobile number to SigninPage
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 140),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Already have an account? Sign in
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the SignInPage
              },
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign in',
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
