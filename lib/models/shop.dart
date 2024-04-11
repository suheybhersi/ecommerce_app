import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
      name: 'Hoodie',
      price: 34.99,
      description: 'Simple black hoodie',
      imagePath: 'assets/hoodie.png',
    ),
    Product(
      name: 'Shoes',
      price: 109.99,
      description: 'Black Jordans',
      imagePath: 'assets/shoes.png',
    ),
    Product(
      name: 'Watch',
      price: 79.99,
      description: 'Black analogue watch',
      imagePath: 'assets/watch.png',
    ),
    Product(
      name: 'Glasses',
      price: 14.99,
      description: 'Round sunglesses',
      imagePath: 'assets/glasses.png',
    )
  ];

  List<Product> _cart = [];

  List<Product> get shop => _shop;
  List<Product> get cart => _cart;
  double total = 0.0;

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }

  void emptyCart() {
    _cart = [];
    notifyListeners();
  }
}
