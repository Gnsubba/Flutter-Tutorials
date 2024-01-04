import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/pages/home/main_food)page.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_column.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(

      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL+product.img.toString(),headers: {'authorization':'Bearer token'}),
                    fit: BoxFit.cover,
                  )
                ),
          )),
          // Icons widget
          Positioned(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                GestureDetector(
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  onTap: (){
                      Get.toNamed(RouteHelper.initial);
                  },
                ),
              GetBuilder<PopularProductController>(builder: (product){
                return Get.find<PopularProductController>().totalItems>=1?GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Stack(

                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined,),
                      Positioned(
                        child: AppIcon(icon: Icons.circle,size: Dimensions.iconSize24*0.90, iconColor: Colors.transparent,backgroundColor: Color(0xFF89dad0),),
                        top: 0, right: Dimensions.width10/2,
                      ),
                      Positioned(child: SmallText(text: product.totalItems.toString(),color: Colors.black87,size: Dimensions.font20*0.9,),
                        top: 0,
                          right: Dimensions.width10,
                      ),
                    ],
                  ),
                ):AppIcon(icon: Icons.shopping_cart_outlined,);
              }),
            ],
          ),
          left: Dimensions.width20,
          right: Dimensions.width20,
          top: Dimensions.height30,),
          // Introduction of food
          Positioned(
            left: 0,
              right: 0,
              top: Dimensions.popularFoodImgSize-Dimensions.height30,
              bottom: 0,
              child: Container(
            padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20), topLeft: Radius.circular(Dimensions.radius20),),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name.toString()),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    // expandable text widget
                    SizedBox(height: Dimensions.height15,),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(text: product.description.toString()),
                        )
                    )
                  ],
                ),
          ))
          

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width30,right: Dimensions.width30),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20)*2, topRight:Radius.circular(Dimensions.radius20)*2 ),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
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
                        popularProduct.setQuantity(false);
                      },
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString(),color: Colors.black87,),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: Colors.black12),),
                  ],
                ),
              ),
            GestureDetector(
              onTap: (){
                popularProduct.addItem(product);
              },
              child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20/1.16,left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(text: "\Rs.${popularProduct.inCartItems*product.price!} | Add to cart"),
                    ),
            ),
            ],
          ),
        );
      },),
      backgroundColor: Colors.white,
    );
  }
}
