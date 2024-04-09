import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_styles.dart';
import '../consts.dart';
import '../size_config.dart';
import '../providers/search_provider.dart';
import '../widgets/searchbar.dart';
import 'dart:math';
import '../push_animation.dart';
import 'restaurant_details.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context, listen: false)
          .updateSearchResults('');
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SearchBarWidget(
                onClear: () {},
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, searchProvider, _) {
                final random = Random();

                final List<Widget> restaurantWidgets = searchProvider
                    .searchResults
                    .where((item) => item is Restaurant)
                    .map((item) => _buildPopularRestaurants(
                        item as Restaurant, Colors.blue))
                    .toList();

                // Limit the display of popular restaurants to 3 and shuffle randomly
                restaurantWidgets.shuffle(random);
                restaurantWidgets.length = min(restaurantWidgets.length, 3);

                final List<Widget> allRestaurantWidgets = searchProvider
                    .searchResults
                    .where((item) => item is Restaurant)
                    .map((item) =>
                        _buildAllRestaurants(item as Restaurant, Colors.blue))
                    .toList();

                final List<Widget> foodWidgets = searchProvider.searchResults
                    .where((item) => item is Food)
                    .map((item) =>
                        _buildRecommendedDishes(item as Food, Colors.orange))
                    .toList();
                foodWidgets.shuffle(random);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Popular Restaurants',
                          style: tPoppinsSemiBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                            color: tBlack4,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: restaurantWidgets,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 8,
                        color: tGrey4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Recommended Dishes',
                          style: tPoppinsSemiBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                            color: tBlack4,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: foodWidgets,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 8,
                        color: tGrey4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('All Restaurants',
                          style: tPoppinsSemiBold.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                            color: tBlack4,
                          )),
                    ),
                    Column(
                      children: allRestaurantWidgets,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularRestaurants(dynamic item, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteUtils.createSlidePageRoute(
              RestaurantDetails(restaurant: item)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRecommendedDishes(dynamic item, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteUtils.createSlidePageRoute(
              RestaurantDetails(restaurant: item.restaurant)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          item.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAllRestaurants(dynamic item, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteUtils.createSlidePageRoute(
              RestaurantDetails(restaurant: item)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: tOrange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Row(
              children: [
                Text(
                  item.name,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
