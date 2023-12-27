import 'dart:async';
import 'myhomescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Wrap the Image widget with Opacity
              Opacity(
                opacity: 0.7, // Set the desired opacity value
                child: Image.asset('assets/images/dress-logo.png'),
              ),
              const SizedBox(
                  height: 10), // Add some space between image and text
              // Wrap the Text widget with Opacity
              const Opacity(
                opacity: 0.7, // Set the desired opacity value
                child: Text(
                  'LuxeLineup',
                  style: TextStyle(
                    fontFamily: 'MainFont',
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
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
