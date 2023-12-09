import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const homescreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
   
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       
        children: [
          Center(
            child: Image.asset(
              "images/splash_pic.jpg",
              fit: BoxFit.cover,
              height: height * .5,
              width: width * .9,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Top Headlines',
            style: GoogleFonts.anton(letterSpacing: 6, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          const SpinKitCircle(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
