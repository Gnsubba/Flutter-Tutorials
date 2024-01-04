import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:e_commerce_app/pages/food/popular_food_detail.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/app_constants.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/icon_and_text_widget.dart';
import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/recommended_product_controller.dart';
import '../../widgets/big_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        // print("current value is "+ _currentPageValue.toString());
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            // color: Colors.redAccent,
            height: Dimensions.pageView,
              child: PageView.builder(itemBuilder: (context,position){

                return _buildPageItem(position,popularProducts.popularProductList[position]);
              },
                controller: pageController,
                itemCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,),

          ):CircularProgressIndicator(
            color: Color(0xFF89dad0),
          );
        }),
        // dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return new DotsIndicator(
            dotsCount: popularProducts.popularProductList.length<=0?1:popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),


        // Popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width:Dimensions.width10,),
                Container(
                    child: SmallText(text: "."),
                    margin: EdgeInsets.only(bottom: 3),
                ),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: SmallText(text: "Food pairing",),
                )

              ]
        ),
    ),
        // List of food and images
        // SizedBox(height: Dimensions.height45,),

        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedProductList.length<=0?1:recommendedProduct.recommendedProductList.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedProduct.recommendedProductList[index].id!));
                },
                child: Container(

                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        // Image Section
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: NetworkImage(AppConstants.BASE_URL+recommendedProduct.recommendedProductList[index].img.toString(),headers: {
                                'authorization':'Bearer ${AppConstants.TOKEN}'
                              }),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white38,
                          ),
                        ),
                        // Text Container
                        Expanded(
                          child: Container(

                            height: Dimensions.listViewTextContSize,
                            width: double.maxFinite,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: recommendedProduct.recommendedProductList[index].description),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: Color(0xFFffd28d)),
                                      IconAndTextWidget(icon: Icons.location_on, text: '1.7Km', iconColor: Color(0xFF89dad0)),
                                      IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: Colors.purple),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              );
            },):CircularProgressIndicator(
            color: Color(0xFF89dad0),
          );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      // print("The current page is"+_currentPageValue.toString());
      // print("The currScale value is:"+ currScale.toString());
      var currTans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTans, 0);
    }
    else if(index==_currentPageValue.floor()+1){
      var currScale = _scaleFactor + (_currentPageValue-index+1)*(1-_scaleFactor);
      var currTans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTans, 0);
    }else if(index==_currentPageValue.floor()-1){
      // print("Entered the else if condition");
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTans, 0);
    }else{
      var currScale = 0.8;
      var currTans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTans, 0);
    }



    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

          Get.toNamed(RouteHelper.getPopularFood(index));
          },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL+popularProduct.img.toString(),headers: {
                      'authorization':'Bearer ${AppConstants.TOKEN}'
                    }),
                  )
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10,),

          Align(
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color:Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5)),
                    BoxShadow(color: Colors.white,
                      offset: Offset(-5,0),
                    ),
                    BoxShadow(color: Colors.white,
                      offset: Offset(5,0),
                    ),
                  ]
              ),
              child: Container(
                padding:EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width15,right: Dimensions.width15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name.toString(),size: 22,),
                    SizedBox(height: Dimensions.height10,),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(int.parse(popularProduct.stars.toString()), (index) => Icon(Icons.star,color: Color(0xFF89dad0),size: 15,)),
                        ),
                        SizedBox(width: Dimensions.width10,),
                        SmallText(text: popularProduct.stars.toString(),size: 14,),
                        SizedBox(width: Dimensions.width10,),
                        SmallText(text: "1222"),
                        SizedBox(width: Dimensions.width10,),
                        SmallText(text: "Comments")

                      ],
                    ),
                    SizedBox(height: Dimensions.height20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: Color(0xFFffd28d)),
                        IconAndTextWidget(icon: Icons.location_on, text: '1.7Km', iconColor: Color(0xFF89dad0)),
                        IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: Colors.purple),
                      ],
                    )
                    ],
                ),
              ),

            ),
            alignment: Alignment.bottomCenter,
          ),
        ]
      ),
    );

  }
}
