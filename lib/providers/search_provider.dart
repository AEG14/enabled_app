import 'package:flutter/material.dart';
import '../consts.dart';

class SearchProvider extends ChangeNotifier {
  List<dynamic> _searchResults = [];

  List<dynamic> get searchResults => _searchResults;

  void updateSearchResults(String query) {
    _searchResults = _filteredResults(query);
    notifyListeners();
  }

  List<dynamic> _filteredResults(String query) {
    List<dynamic> allItems = [];
    allItems.addAll(restaurants); // Add all restaurants

    // Iterate over each restaurant and add its foods
    restaurants.forEach((restaurant) {
      allItems.addAll(restaurant.foods);
    });

    // Filter based on query
    return allItems.where((item) {
      if (item is Restaurant) {
        return item.name.toLowerCase().contains(query.toLowerCase());
      } else if (item is Food) {
        return item.name.toLowerCase().contains(query.toLowerCase());
      }
      return false;
    }).toList();
  }
}
