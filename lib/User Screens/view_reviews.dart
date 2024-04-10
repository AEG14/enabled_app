import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enabled_app/User%20Screens/leave_review.dart';
import 'package:enabled_app/app_styles.dart';
import 'package:enabled_app/push_animation.dart';
import 'details_page.dart';

class ViewReviewsScreen extends StatefulWidget {
  final DocumentSnapshot enabledLocation;
  ViewReviewsScreen({Key? key, required this.enabledLocation});

  @override
  _ViewReviewsScreenState createState() => _ViewReviewsScreenState();
}

class _ViewReviewsScreenState extends State<ViewReviewsScreen> {
  late CollectionReference enabledReviewsRef;
  late Future<QuerySnapshot> reviewsFuture;

  @override
  void initState() {
    super.initState();
    enabledReviewsRef =
        FirebaseFirestore.instance.collection('ENABLED_reviews');
    reviewsFuture = enabledReviewsRef.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteUtils.createSlidePageRoute(
                EnabledLocationDetails(enabledLocation: widget.enabledLocation),
              ),
            );
          },
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: reviewsFuture,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 18),
                        Text(
                          "4.0",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                              ],
                            ),
                            SizedBox(width: 8),
                            Text("5 Reviews"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> reviewData =
                              document.data() as Map<String, dynamic>;

                          return ListTile(
                            title: Row(
                              children: [
                                Text(reviewData['userName']),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                                Icon(Icons.star, color: Colors.amber),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reviewData['feedback']),
                                SizedBox(height: 10),
                              ],
                            ),
                            leading: CircleAvatar(
                              child: Text('R'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteUtils.createSlidePageRoute(
                        LeaveReviewScreen(
                            enabledLocation: widget.enabledLocation),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
