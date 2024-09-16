import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import the SignInPage
import 'dashboard_page.dart'; // Import the DashboardPage
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  final String mobileno;
  const SignupPage({super.key, required this.mobileno}); // Constructor that accepts mobile number

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedRole = 'Farmer'; // Default value for the dropdown
  final TextEditingController nameController = TextEditingController(); // Name input controller
  final TextEditingController mobileController = TextEditingController(); // Mobile input controller
  String nameErrorMessage = ''; // Error message for Name field
  bool isAuthenticated = false; // Flag to check if user is already authenticated

  @override
  void initState() {
    super.initState();
    mobileController.text = widget.mobileno; // Initialize mobile field with the provided number
    // Here you can add logic to check if the user is already authenticated
    // For demo purposes, we'll assume the user is not authenticated.
    // If they are authenticated, you can set the isAuthenticated flag to true.
  }

  Future<void> register(String name, String type, String phoneNumber) async {
    final response = await http.post(
      Uri.parse('http://localhost:8585/api/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "type": type,
        "mobileno": phoneNumber
      }),
    );

    if (response.statusCode == 200) {
      print("Registered");
      // After registration, navigate to the dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()), // Navigate to DashboardPage
      );
    } else {
      print("Failed to Register");
      // Handle registration failure (e.g., show error message)
    }
  }

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
                labelStyle: const TextStyle(color: Colors.black54), // Set label color here
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
              readOnly: true, // Mobile number is not editable
              decoration: InputDecoration(
                labelText: 'Mobile No.',
                labelStyle: const TextStyle(color: Colors.black54), // Set label color here
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
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
              items: const [
                DropdownMenuItem(value: 'Farmer', child: Text('Farmer')),
                DropdownMenuItem(value: 'Retailer', child: Text('Retailer')),
                DropdownMenuItem(value: 'Consumer', child: Text('Consumer')),
              ],
            ),
            const SizedBox(height: 30),
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                if (isAuthenticated) {
                  // If the user is authenticated, navigate to the dashboard directly
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()), // Navigate to DashboardPage
                  );
                } else {
                  // Otherwise, proceed with registration
                  String name = nameController.text.trim();
                  if (name.isEmpty) {
                    setState(() {
                      nameErrorMessage = 'Name is required';
                    });
                  } else {
                    setState(() {
                      nameErrorMessage = ''; // Clear error
                    });
                    register(name, _selectedRole, widget.mobileno); // Register the user
                  }
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
                'SIGN UP',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            // Already have an account? Sign in link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? ', style: TextStyle(fontSize: 16, color: Colors.black54)),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage(mobileNumber: widget.mobileno)),
                    );
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
