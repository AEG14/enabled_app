import 'package:flutter/material.dart';
import '../main.dart';
import '../push_animation.dart';
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
            title: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage(
                                'assets/images/user1.jpg',
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Harley Mamalias',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Profile Information',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(fontSize: 15),
                          ),
                          Expanded(
                            child: Text(
                              '${userDetails['username']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${userDetails['firstName']} ${userDetails['lastName']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'User ID',
                            style: TextStyle(fontSize: 15),
                          ),
                          Expanded(
                            child: Text(
                              '096237',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${userDetails['email']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${userDetails['phoneNumber']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Male',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '02 Feb, 1994',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'City of Naga',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

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
                  Divider(),  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
