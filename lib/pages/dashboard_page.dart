import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example functionality: Navigate to a different page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()), // Replace with your actual page
                );
              },
              child: Text('Go to Profile'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement a logout functionality if needed
                Navigator.pop(context); // This will go back to the previous page
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of ProfilePage, replace this with actual functionality
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Center(
        child: Text('This is the profile page'),
      ),
    );
  }
}
