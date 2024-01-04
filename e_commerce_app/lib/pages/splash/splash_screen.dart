import 'dart:async';

import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;


  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 3),)..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 3), () {
      Get.offNamed(RouteHelper.initial);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
        scale: animation,
        child: Center(
          child: Image.asset('assets/image/logo 1.png',width: Dimensions.iconSize24*10,),
        ),
      ),
    );
  }
}
