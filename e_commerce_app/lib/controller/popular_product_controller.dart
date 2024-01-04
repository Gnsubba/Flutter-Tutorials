
import 'dart:ui';

import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/data/repository/popular_product_repo.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  late CartController _cart;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded  => _isLoaded;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems;

  late List<Map<String,dynamic>> storage;
  Future<void> getPopularProductList() async{
    // print("getPopularProductList method called");
    Response response = await popularProductRepo.getPopularProductList();
    // print(response.status.code);
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); // same as setState()
    }
    else{

    }
  }

  void setQuantity(bool isIncrement){
    isIncrement?_inCartItems>=20?_inCartItems=20:_inCartItems+=1:_inCartItems==0?_inCartItems=0:_inCartItems-=1;
    update();
  }


  void addItem(ProductModel product){
    print("The current value of _inCartItem is "+_inCartItems.toString());
    _cart.addItem(product, _inCartItems);
    _cart.items.forEach((key, value) {
      print('Product with id: '+key.toString()+" and total quantity is: "+value.quantity.toString());
    });
    update();
  }

  void initProduct(ProductModel product,CartController cart){
    _inCartItems = 0;
    // get from storage _inCartItems = 3
    _cart = cart;
    var exists = _cart.existInCart(product);
    if(exists){
      _inCartItems = _cart.getQuantity(product);
    }
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getCartItems{
    return _cart.getCartItems;
  }
}