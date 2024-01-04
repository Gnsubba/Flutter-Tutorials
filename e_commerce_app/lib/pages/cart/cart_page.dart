import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/pages/home/main_food)page.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/popular_product_model.dart';
class Cartpage extends StatelessWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      print('back clicked');
                      Get.toNamed(RouteHelper.initial);
                    },
                      child: AppIcon(icon: Icons.arrow_back_ios,iconColor: Colors.white,backgroundColor: Color(0xFF89dad0),size: Dimensions.iconSize24*1.5,)),
                  SizedBox(width: Dimensions.width30*6,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.initial);
                    },
                      child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,backgroundColor: Color(0xFF89dad0),size: Dimensions.iconSize24*1.5,)),
                  AppIcon(icon: Icons.shopping_cart,iconColor: Colors.white,backgroundColor: Color(0xFF89dad0),size: Dimensions.iconSize24*1.5,),

                ],
          )),
          Positioned(top:Dimensions.height20*6,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              // color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cart){
                  var cartList = cart.getCartItems;
                  return cartList.length==0?Container(
                    child: Center(
                      child: Container(child: BigText(text:"The cart is Empty",size: Dimensions.font26,)),
                    ),
                  ):ListView.builder(
                      itemCount: cartList.length,

                      itemBuilder: (_,index){
                        return Container(

                          height: 100,width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  print("The value of id is: "+cartList[index].id.toString());
                                  Get.toNamed(RouteHelper.getRecommendedFood(cartList[index].id!));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    height: Dimensions.height20*5,
                                    width: Dimensions.height20*5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage(AppConstants.BASE_URL+cartList[index].img!.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    )
                                ),
                              ),
                              SizedBox(width: Dimensions.width20,),
                              Expanded(child: Container(
                                margin: EdgeInsets.only(bottom: Dimensions.height10),
                                height: Dimensions.height20*5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(text: cartList.length==0?"Empty":cart.getCartItems[index].name.toString(), color: Colors.black54,),
                                    SmallText(text: "Spicy"),
                                    Container(
                                      padding: EdgeInsets.only(right: Dimensions.width20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: "Rs.${cartList[index].price!}", color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimensions.height20/1.6,bottom: Dimensions.height20/1.8, left: Dimensions.width20, right: Dimensions.width20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Icon(Icons.remove, color: Colors.black12),
                                                  onTap: (){
                                                    // popularProduct.setQuantity(false);
                                                    cart.changeQuantityByProductId(cartList[index].id!, false);
                                                  },
                                                ),
                                                SizedBox(width: Dimensions.width10/2,),
                                                BigText(text: "${cartList[index].quantity}",color: Colors.black87,),
                                                SizedBox(width: Dimensions.width10/2,),
                                                GestureDetector(
                                                  onTap: (){
                                                    // popularProduct.setQuantity(true);
                                                    cart.changeQuantityByProductId(cartList[index].id!, true);
                                                  },
                                                  child: Icon(Icons.add, color: Colors.black12),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      });
                },)
              ),
          ) ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cart){
        return cart.getCartItems.length>=1?Container(
          height: Dimensions.height20*4,
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,),
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Dimensions.height45*1.2,
                  width: Dimensions.height45*3,

                  padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Color(0xFF89dad0)
                  ),
                  child: Center(child: BigText(text: 'Rs.'+cart.getTotalPrice().toString()))),
              GestureDetector(
                onTap: (){
                  print("Clicked check-out");
                  cart.addToCart();
                },
                child: Container(
                  height: Dimensions.height45*1.2,
                  width: Dimensions.height45*3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Color(0xFF89dad0)
                  ),
                  child: Center(
                    child: BigText(text: "Check-out"),
                  ),
                ),
              )
            ],
          ),
        ):Text('');
      },
         
      ),
    );
  }
}
