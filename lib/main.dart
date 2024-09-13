import 'package:flutter/material.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}
Varun bhai chi hava nusta dhurr
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  //shivam bhai murdabaad
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}