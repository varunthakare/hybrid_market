import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import the sign-in page

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String? selectedLanguage; // To hold the selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with top margin
          Positioned.fill(
            top: 30, // Added top margin
            child: Image.asset(
              'lib/images/intro_img.png',
              fit: BoxFit.cover, // Fully cover the screen
            ),
          ),
          // Positioned Dropdown and Button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.68, // Adjusted the top margin
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dropdown Button with margin
                Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 50), // Added margin between dropdown and button
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2), // Green border
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white, // White background
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      hint: const Text(
                        'Select Language', // Dropdown title
                        style: TextStyle(color: Colors.green), // Green text color
                      ),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.green), // Green icon
                      dropdownColor: Colors.white, // White dropdown background
                      items: <String>['English', 'मराठी', 'हिंदी', 'ગુજરાતી']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.green), // Green text color
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLanguage = newValue;
                        });
                      },
                    ),
                  ),
                ),
                // Get Started Button with larger font size
                ElevatedButton(
                  onPressed: () {
                    if (selectedLanguage != null) {
                      // Navigate to sign-in page if a language is selected
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SigninPage()),
                      );
                    } else {
                      // Show a message if no language is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a language')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800], // Dark green button
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 18, // Increased font size
                        ), 
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        color: Colors.white, 
                        size: 30, // Increased arrow size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
