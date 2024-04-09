import 'package:enabled_app/User%20Screens/map_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../app_styles.dart';
import '../consts.dart';
import '../size_config.dart';
import '../push_animation.dart';
// import 'navigation.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnabledLocationDetails extends StatelessWidget {
  final DocumentSnapshot enabledLocation;
  EnabledLocationDetails({required this.enabledLocation});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: tWhite,
              child: Column(
                children: [
                  enabledLocation['locationImage'] != null
                      ? FutureBuilder(
                          future: FirebaseStorage.instance
                              .ref(enabledLocation['locationImage'])
                              .getDownloadURL(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                                height: SizeConfig.blockSizeVertical! * 50,
                                width: double.infinity,
                                alignment: Alignment.center,
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                color: tWhite3,
                                height: SizeConfig.blockSizeVertical! * 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        tBlack), // Set the color here
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                color: tGrey3,
                                height: SizeConfig.blockSizeVertical! * 50,
                              );
                            }
                          },
                        )
                      : Container(
                          color: tGrey3,
                          height: SizeConfig.blockSizeVertical! * 50,
                        ),
                ],
              ),
            ),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: tWhite,
                height: SizeConfig.blockSizeVertical! * 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 7,
                      ),
                      Center(
                        child: Container(
                          height: SizeConfig.blockSizeVertical! * 39,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    21.89, 17.3, 21.89, 4),
                                child: Text(
                                  enabledLocation['description'],
                                  style: tPoppinsRegular.copyWith(
                                      color: tBlack4,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! *
                                              3.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    21.89, 17.3, 21.89, 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8.76,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Accessibilities Available:",
                                          style: tPoppinsBold.copyWith(
                                              color: tBlack4,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal! *
                                                  3.5),
                                        ),
                                        for (String accessibility
                                            in enabledLocation['accessibility'])
                                          Text('• $accessibility',
                                              style: tPoppinsRegular.copyWith(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal! *
                                                    3,
                                                color: tBlack3,
                                              )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteUtils.createSlidePageRoute(
                                          MapPage(
                                              enabledLocation:
                                                  enabledLocation)),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text('GET DIRECTIONS'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.blockSizeVertical! * 43.2,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  height: SizeConfig.blockSizeVertical! * 13,
                  decoration: BoxDecoration(
                    color: tWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0A171439),
                        blurRadius: 43.78,
                        spreadRadius: 0,
                        offset: Offset(0, 5.47),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(26.27),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26.27),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                      child: Container(
                        color: Colors
                            .transparent, // Make sure to set a transparent color
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 21.89),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    enabledLocation['name'] +
                                        ' · ' +
                                        enabledLocation['overallRating']
                                            .toString(),
                                    style: tPoppinsBold.copyWith(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                4.5,
                                        color: tBlack3),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text('View Reviews'),
                            ],
                          ),
                        ),
                      ),
                    ),
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
