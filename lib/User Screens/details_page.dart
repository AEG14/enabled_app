import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../app_styles.dart';
import '../consts.dart';
import '../size_config.dart';
import '../push_animation.dart';
// import 'navigation.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatelessWidget {
  final DocumentSnapshot enabledLocation;
  DetailsPage({required this.enabledLocation});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: tOrange,
              child: Column(
                children: [
                  enabledLocation['locationImage'] != null
                      ? Image.network(
                          enabledLocation['locationImage'],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        )
                      : Image.asset(
                          'assets/jollibeestore1.jpg',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
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
                                child: Row(
                                  children: [
                                    Container(
                                      height: 26.27,
                                      width: 26.27,
                                      decoration: BoxDecoration(
                                        color: tOrange,
                                        // borderRadius:
                                        //     BorderRadius.circular(8.76),
                                        // image: DecorationImage(
                                        //   image: AssetImage(
                                        //       "assets/images/chef.png"),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                    ),
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
                                                    4,
                                                color: tBlack3,
                                              )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                child: Text(
                                  'Go Now',
                                  style: tPoppinsRegular.copyWith(
                                      color: tBlack4,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! *
                                              3.5),
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
                                  // Text(
                                  //   enabledLocation.address,
                                  //   style: tPoppinsRegular.copyWith(
                                  //       fontSize:
                                  //           SizeConfig.blockSizeHorizontal! * 3,
                                  //       color: tGrey3),
                                  // ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 39.4,
                                width: 39.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.76),
                                  color: tGrey3,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/HatodLogo.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
