
import 'dart:convert';

import 'package:e_commerce_app/data/repository/cart_repo.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel>  _items={};


  Map<int, CartModel> get items => _items;
  void addItem(ProductModel product,int  quantity){
    if(quantity==0){
      Get.snackbar("Item count", "Cannot add the 0 quantity in the cart. Select atLeast 1 quantity",
      backgroundColor: Color(0xFF89dad0),
      duration: Duration(milliseconds: 1000),
      );
    }
    else if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) => CartModel.fromJson({
        "id":value.id,
        "name": value.name,
        'price':value.price,
        'quantity':quantity,
        'isExist':true,
        'time' : DateTime.now().toString(),
        'img' : value.img
      }));
    }
    else{
      _items.putIfAbsent(product.id!,(){
        return CartModel.fromJson({
          "id":product.id,
          "name": product.name,
          'price':product.price,
          'quantity':quantity,
          'isExist':true,
          'time' : DateTime.now().toString(),
          'img' : product.img
        }
        );  });
    }
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    _items.forEach((key, value) {
      if(key==product.id){
        quantity = value.quantity!;
      }
    }
    );
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity+value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getCartItems{
    return _items.entries.map((e) => e.value).toList();
  }


  void changeQuantityByProductId(int productId, bool inc){

    if(_items.containsKey(productId)) {
      _items.removeWhere((key, value) => key==productId&&value.quantity==1&&inc==false);

      inc?_items.update(productId, (value) =>
          CartModel.fromJson({
            "id": value.id,
            "name": value.name,
            'price': value.price,
            'quantity': value.quantity! + 1,
            'isExist': true,
            'time': DateTime.now().toString(),
            'img': value.img
          })):_items.containsKey(productId)?_items.update(productId, (value) => CartModel.fromJson({
          "id":value.id,
          "name": value.name,
          'price':value.price,
          'quantity':value.quantity!-1,
          'isExist':true,
          'time' : DateTime.now().toString(),
          'img' : value.img
        })):print('Product deleted from cart');
      }
    update();
  }

  int getTotalPrice(){
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  void addToCart(){

    bool result = cartRepo.addToCartList(_items.values.toList());
    _items = {};
    if(result){
      Get.snackbar('Checked out', "Checked out from the cart",duration: Duration(milliseconds: 1000));
      // List cartList = Get.find<CartRepo>().sharedPreferences.get('cart-list') as List;
      // cartList.forEach((element) {print(element);});
    }
    else{
      Get.snackbar('Error', "Not checked out");
    }
    update();
  }


  List<List<CartModel>> getCartList(){
    // cartRepo.sharedPreferences.remove('cart-list');
    List<List<CartModel>> list = [];
    List<CartModel> cartList = [];
    List list1 = cartRepo.sharedPreferences.get('cart-list')==null?[]:cartRepo.sharedPreferences.get('cart-list') as List;
    list1.forEach((element) {
      cartList = [];
      // List<dynamic>  cartList1 = jsonDecode(element) as List<dynamic>;
      // list.add(cartList);
      List elementList = jsonDecode(element) as List;
      elementList.forEach((element1) {
        CartModel cartElement = CartModel.fromJson(element1);
        cartList.add(cartElement);
      });
      list.add(cartList);
    });
    return list;
  }

  int getTotalPriceFromCartList(){
    int total =0 ;
    List<List<CartModel>> list = getCartList() as List<List<CartModel>>;
    list.forEach((element) {
      element.forEach((element1) {
        total += (element1.price!*element1.quantity!);
      });

    // print(element.quantity!*element.price!);
    // print(total);
    });
    return total;
  }
}