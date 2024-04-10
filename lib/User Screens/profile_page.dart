import 'package:flutter/material.dart';
import '../app_styles.dart';
import '../main.dart';
import '../push_animation.dart';
import '../size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:enabled_app/providers/firebaseFunctions.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userService =
        ENABLED_userservice(); // Instantiate the UserService directly

    return FutureBuilder<Map<String, dynamic>>(
      future: userService.getUserDetails(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        final userDetails = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteUtils.createSlidePageRoute(
                      MyHomePage(title: 'ENABLED')),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  // Center(
                  //   child: userDetails['profilePicture'] != null
                  //       ? FutureBuilder<String>(
                  //           future: FirebaseStorage.instance
                  //               .ref(userDetails['profilePicture'])
                  //               .getDownloadURL(),
                  //           builder: (BuildContext context,
                  //               AsyncSnapshot<String> snapshot) {
                  //             if (snapshot.connectionState ==
                  //                 ConnectionState.done) {
                  //               return Container(
                  //                 width: 120,
                  //                 height: 120,
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   image: DecorationImage(
                  //                     image: NetworkImage(snapshot.data!),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //               );
                  //             } else if (snapshot.connectionState ==
                  //                 ConnectionState.waiting) {
                  //               return Container(
                  //                 width: 120,
                  //                 height: 120,
                  //                 color: tWhite3,
                  //                 child: Center(
                  //                   child: CircularProgressIndicator(
                  //                     valueColor: AlwaysStoppedAnimation<Color>(
                  //                         tBlack), // Set the color here
                  //                   ),
                  //                 ),
                  //               );
                  //             } else {
                  //               return Container(
                  //                 width: 120,
                  //                 height: 120,
                  //                 color: tGrey3,
                  //               );
                  //             }
                  //           },
                  //         )
                  //       : Container(
                  //           width: 120,
                  //           height: 120,
                  //           color: tGrey3,
                  //         ),
                  // ),
                  SizedBox(height: 20.0),
                  Text(
                    'Username: ${userDetails['username']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'First Name: ${userDetails['firstName']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Last Name: ${userDetails['lastName']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Email: ${userDetails['email']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Phone Number: ${userDetails['phoneNumber']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
