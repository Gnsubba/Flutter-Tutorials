import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/controller/popular_product_controller.dart';
import 'package:e_commerce_app/controller/recommended_product_controller.dart';
import 'package:e_commerce_app/pages/auth/login_page.dart';
import 'package:e_commerce_app/pages/auth/sign_up_page.dart';
import 'package:e_commerce_app/pages/cart/cart_list.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/pages/food/recommended_food_detail.dart';
import 'package:e_commerce_app/pages/home/food_page_body.dart';
import 'package:e_commerce_app/pages/home/home_page.dart';
import 'package:e_commerce_app/pages/home/main_food)page.dart';
import 'package:e_commerce_app/pages/splash/splash_screen.dart';
import 'package:e_commerce_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: LoginPage(),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          );


      });
    });
  }
}




