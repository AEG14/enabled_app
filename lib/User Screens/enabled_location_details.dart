import 'package:flutter/material.dart';
import '../app_styles.dart';
import '../consts.dart';
import '../size_config.dart';
import '../push_animation.dart';
// import 'navigation.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../push_animation.dart';
import 'user_home.dart';

class EnabledLocationDetails extends StatelessWidget {
  final DocumentSnapshot enabledLocation;
  EnabledLocationDetails({required this.enabledLocation});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 28, 10, 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 3), // Offset in the x, y direction
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                color: tWhite,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned.fill(
              child: Image.network(
                'https://picsum.photos/250?image=9',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 16.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteUtils.createSlidePageRoute(UserHome()),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        enabledLocation['name'],
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 39.4,
                            width: 39.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.76),
                              color: tGrey3,
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/HatodLogo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(enabledLocation['overallRating'].toString()),
                          Text('View Reviews'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        enabledLocation['description'],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Accessibilities Available:",
                            style: tPoppinsBold.copyWith(
                                color: tBlack4,
                                fontSize:
                                    SizeConfig.blockSizeHorizontal! * 3.5),
                          ),
                          for (String accessibility
                              in enabledLocation['accessibility'])
                            Text('• $accessibility',
                                style: tPoppinsRegular.copyWith(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: tBlack3,
                                )),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
//
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.amber,
                          ),
                          child: const Text('GET DIRECTIONS'),
                        ),
                      ),
                    ],
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
