import 'package:enabled_app/app_styles.dart';
import 'package:enabled_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../push_animation.dart';
import 'dart:async'; 

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {

    Future<void> navigateToNextPage() async {
      await Future.delayed(Duration(seconds: 2)); // 2-second delay
      Navigator.push(
                    context,
                    PageRouteUtils.createSlidePageRoute(MyApp()),
                  );
    }

    navigateToNextPage();

    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Circle_logo.png', 
            width: 200,
            height: 200,
          ),
          SizedBox(height: 100),
          Text('ENABLED', style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: tBlack,
                      fontSize: 40, ),),
        ],
      ),
    );
  }
}
