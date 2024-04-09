import 'package:enabled_app/User%20Screens/view_reviews.dart';
import 'package:enabled_app/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../push_animation.dart';

class LeaveReviewScreen extends StatelessWidget {
  LeaveReviewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave a Review'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
            ],
          ),
          SizedBox(height: 10),
          Text('Excellent', style: TextStyle(fontSize: 30),),
          Text('You rated _____ _ star'),
          SizedBox(height: 30),
          Container(
            width: 300,
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteUtils.createSlidePageRoute(ViewReviewsScreen()),
                  );
                },
                child: Container(
                  child: Text(
                    'Submit review',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: tBlack,
                      fontSize: 15,
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
