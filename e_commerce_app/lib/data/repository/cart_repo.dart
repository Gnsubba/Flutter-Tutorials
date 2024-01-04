import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo extends GetxService{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  String time = DateTime.now().toString();
  List<String> cart = [];
  List<CartModel> cartListByDate = [];
  bool addToCartList(List<CartModel> cartList){
    cart = [];
    cart = sharedPreferences.getStringList('cart-list')==null?[]:sharedPreferences.getStringList('cart-list') as List<String>;
    // convert objects to string because sharedPreferences only accepts String
    cartList.forEach((element) {
      element.time = time;
      cartListByDate.add(element);
    });
    cart.add(jsonEncode(cartListByDate));
    sharedPreferences.setStringList('cart-list', cart);
    // print('The shared obj is: '+sharedPreferences.get('cart-list').toString());
    return true;
  }
}