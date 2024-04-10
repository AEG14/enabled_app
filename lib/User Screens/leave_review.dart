import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../push_animation.dart';
import 'view_reviews.dart';

class LeaveReviewScreen extends StatefulWidget {
  final DocumentSnapshot enabledLocation;

  LeaveReviewScreen({Key? key, required this.enabledLocation});

  @override
  _LeaveReviewScreenState createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  double _rating = 0;
  TextEditingController _reviewController = TextEditingController();

  String getReviewText(double rating) {
    if (rating == 0) {
      return 'Please rate the location';
    } else if (rating == 5) {
      return 'Excellent';
    } else if (rating >= 4) {
      return 'Good';
    } else if (rating >= 3) {
      return 'Great';
    } else if (rating >= 2) {
      return 'Bad';
    } else {
      return 'Worst';
    }
  }

  void submitReview() async {
    String reviewText = _reviewController.text;
    String userName = "Harley Mamalias";
    String profilePicture = "profilePictures/harls.jpg";
    String reviewId = widget.enabledLocation.id;

    // Get a reference to the Firestore collection
    CollectionReference reviewsCollection =
        FirebaseFirestore.instance.collection("ENABLED_reviews");

    // Add the review data to Firestore
    await reviewsCollection.doc(reviewId).set({
      'feedback': reviewText,
      'rating': _rating,
      'userName': userName,
      'photo': profilePicture,
    });

    // Navigate back to the previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave a Review'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteUtils.createSlidePageRoute(
                  ViewReviewsScreen(enabledLocation: widget.enabledLocation)),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              getReviewText(_rating),
              style: TextStyle(fontSize: 30),
            ),
            Text('You rated $_rating star(s)'),
            SizedBox(height: 30),
            Container(
              width: 300,
              height: 100,
              child: TextField(
                controller: _reviewController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your text',
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: submitReview,
              child: Container(
                child: Text(
                  'Submit review',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
