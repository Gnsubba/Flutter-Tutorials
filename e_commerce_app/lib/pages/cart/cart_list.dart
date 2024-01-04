import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/data/repository/cart_repo.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>();
    return GetBuilder<CartController>(builder: (cartController) {
      List cartList = Get.find<CartController>().getCartList();
      return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          height: Dimensions.height45,
          color: Colors.white24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
              children:[
            BigText(text:"Total: Rs."+cartController.getTotalPriceFromCartList().toString(),color: Color(0xFF89dad0),)
          ], ),
        ),
        body: Container(
          width: double.maxFinite,
          height: Dimensions.height45 * 10,
          // color: Colors.grey,
          child: Container(
            height: Dimensions.height45*10,
            width: double.maxFinite,

            child: ListView.builder(
              itemCount: cartList.isNotEmpty?cartList.length:1,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(height: Dimensions.height10,),
                    BigText(text: cartList[index][0].time!.toString().substring(0,19)),

                      Row(
                        children:[ Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(cartList[index].length, (index1) => Container(
                            height: Dimensions.height45,
                            width: Dimensions.height45,
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.raduis15/2),
                              image: DecorationImage(image: NetworkImage(AppConstants.BASE_URL+cartList[index][index1].img!),fit: BoxFit.cover,),),
                          )),
                        ),
                ]
                      )


                  ],
                );
      },

      ),
          )));
      // return Scaffold(
      //   bottomNavigationBar: Container(
      //     padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
      //     height: Dimensions.height45,
      //     color: Colors.white24,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //         children:[
      //       BigText(text:"Total: Rs."+cartController.getTotalPriceFromCartList().toString(),color: Color(0xFF89dad0),)
      //     ], ),
      //   ),
      //   body: Container(
      //     width: double.maxFinite,
      //     height: Dimensions.height45 * 10,
      //     // color: Colors.grey,
      //     child: ListView.builder(itemBuilder: (context, index) {
      //
      //       return Container(
      //         height: Dimensions.height45*1.5,
      //         width: double.maxFinite,
      //         color: Colors.white38,
      //         margin: EdgeInsets.only(top: Dimensions.height10,
      //             left: Dimensions.width20,
      //             right: Dimensions.width20),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children:[
      //             Text(cartList[index].time.toString()),
      //             Row(
      //               children: [
      //                 GestureDetector(
      //                   child: Container(
      //                     height: Dimensions.height45,
      //                     width: Dimensions.height45,
      //                     // width: Dimensions.width30,
      //                     decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                           image: NetworkImage(AppConstants.BASE_URL+cartList[index].img!),
      //                           fit: BoxFit.cover
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
      //                     height: Dimensions.height45,
      //
      //                     // color: Colors.redAccent,
      //                     padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children:[
      //                       BigText(text: cartList[index].name!,size: Dimensions.font16,),
      //                       BigText(text: cartList[index].quantity!.toString()+' x ' + cartList[index].price!.toString()+' = ' + '${cartList[index].quantity*cartList[index].price}',size: Dimensions.font16,),
      //                     ],),
      //                   ),
      //                 )
      //               ],
      //             )
      //
      //           ]
      //
      //         ),
      //       );
      //     },
      //     itemCount: cartList.length>=1?cartList.length:1,),
      //   ),
      // );
    });
  }
}
