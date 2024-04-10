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
      await Future.delayed(Duration(seconds: 4));
      Navigator.push(
        context,
        PageRouteUtils.createSlidePageRoute(MyHomePage(title: 'ENABLED')),
      );
    }

    navigateToNextPage();

    return Scaffold(
      backgroundColor: Color(0xFF75D481),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 300),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'ENABLED',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: tWhite,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
