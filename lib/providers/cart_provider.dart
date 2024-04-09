import 'package:flutter/material.dart';
import '../consts.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> _items = [];

  List<Food> get items => _items;

  void add(Food item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Food item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  double getCartTotal() {
    return _items.fold(0, (previousValue, item) => previousValue + item.price);
  }
}
