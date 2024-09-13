import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55.0), // top margin/padding
            child: Image.asset(
              'lib/images/intro_img.png',
              height: MediaQuery.of(context).size.height * 0.93, // 80% of screen height
              width: double.infinity, // full width
              fit: BoxFit.contain, // scale to fit without cropping
            ),
          )
        ],
      ),
    );
  }
}
