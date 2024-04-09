import 'package:enabled_app/User%20Screens/leave_review.dart';
import 'package:enabled_app/push_animation.dart';
import 'package:flutter/material.dart';

class ViewReviewsScreen extends StatelessWidget {
  ViewReviewsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      "4.2",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    SizedBox(width: 8),
                    Text("12 Reviews"),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(8, (index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text('Review Title $index'),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              'very helpful sila paras mga disabled pariha namong mga negro. lami pajud balbal balblab lalblabl abla lblab lal balb lablalblabla blalba lblablab $index',
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                      );
                    }),
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
                  PageRouteUtils.createSlidePageRoute(LeaveReviewScreen()),
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
      ),
    );
  }
}
