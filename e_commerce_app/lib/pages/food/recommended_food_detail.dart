import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/controller/recommended_product_controller.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../widgets/small_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int productId;
  const RecommendedFoodDetail({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel? product = Get.find<RecommendedProductController>().findProductById(productId);
    Get.find<PopularProductController>().initProduct(product!,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: AppIcon(icon: Icons.clear,),
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                // color: Colors.white,
                child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20),topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow[300],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+product.img!.toString(), width: double.maxFinite,fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableText(text: product.description!),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,),
                )
              ],
            )
    )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (product1){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20*2.5,right: Dimensions.width20*2.5,top: Dimensions.height10, bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(

                    child:AppIcon(icon: Icons.remove,backgroundColor: Color(0xFF89dad0),iconColor: Colors.white,size: Dimensions.iconSize24*1.5,),
                    onTap: (){
                      product1.setQuantity(false);
                    },
                      ),
                  BigText(text: "Rs.${product.price}  X  ${product1.inCartItems}",size: Dimensions.font26,color: Color(0xFF89dad0),),
                  GestureDetector(
                    onTap: (){
                      product1.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,backgroundColor: Color(0xFF89dad0),iconColor: Colors.white,size: Dimensions.iconSize24*1.5,),

                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width30,right: Dimensions.width30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20)*2, topRight:Radius.circular(Dimensions.radius20)*2 ),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20/1.6,bottom: Dimensions.height20/1.8, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.grey[200],
                      ),
                      child: Icon(Icons.favorite, color: Color(0xFF89dad0),size: Dimensions.iconSize24*1.5,)
                  ),
              GestureDetector(
                onTap: (){
                product1.addItem(product);
                },
                child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Color(0xFF89dad0),
                    ),
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20/1.16,left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(text: "Rs.${product1.inCartItems==0?product.price!:product.price!*product1.inCartItems} | Add to cart"),
                  )
        )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
