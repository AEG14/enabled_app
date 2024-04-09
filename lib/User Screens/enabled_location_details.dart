import 'package:flutter/material.dart';

import '../push_animation.dart';
import 'user_home.dart';

class EnabledLocationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
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
                        'SIOMEW',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('La Pinos Pizza'),
                          Text('View Reviews'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          'Lorem ipsum dolor sit amet consectetur. Sagittis arcu malesuada eu sagittis elementum eget. Mi pellentesque elit sed sed. Elit tristique mi tincidunt tristique lacus elementum tortor sed. Eget amet maecenas dolor eu lectus non est ultrices sit. Ullamcorper quam aliquam nec quis dolor. Etiam cras tortor dui mauris aliquam mattis.'),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Accessibility: '),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Wheelchair Ramp'),
                      Text('ASL Trained Staff'),
                      Text('Elevator'),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Buying not supported yet.'),
                              ),
                            );
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
