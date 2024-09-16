import 'package:flutter/material.dart';

class FarmerDashPage extends StatelessWidget {
  final bool hasProducts = false; // Set to true if products are available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background for the body
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Disable the back button
        title: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Add Product button functionality here
              },
              icon: Icon(Icons.add, color: Colors.green),
              label: Text(
                "Add Product",
                style: TextStyle(color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black54),
              onPressed: () {
                // Notification button functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.message, color: Colors.black54),
              onPressed: () {
                // Message button functionality
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200], // Light gray color for the rest of the body
        child: Center(
          child: hasProducts
              ? Text(
                  "Farmer Dashboard Content",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                )
              : Text(
                  "No Product is Added",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
        ),
      ),
    );
  }
}
