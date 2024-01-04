import 'package:e_commerce_app/models/popular_product_model.dart';
import 'package:e_commerce_app/pages/auth/login_page.dart';
import 'package:e_commerce_app/pages/cart/cart_list.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/pages/food/popular_food_detail.dart';
import 'package:e_commerce_app/pages/food/recommended_food_detail.dart';
import 'package:e_commerce_app/pages/home/home_page.dart';
import 'package:e_commerce_app/pages/home/main_food)page.dart';
import 'package:e_commerce_app/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
class RouteHelper{
  static const String initial = "/";
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String splashScreen = '/splash-screen';

  static String getInitial()=> '$initial';
  // static String getPopularFood(ProductModel product)=>'$popularFood?product=$product';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood(int productId)=>'$recommendedFood?productId=$productId';
  static String getCartPage() => '$cartPage';
  static String getSplashScreen() => '$splashScreen';

  static List<GetPage> routes = [
    GetPage(name: initial, page: (){
      return LoginPage();
  }),
    // GetPage(name: popularFood, page: (){
    //   print("getPopularFood() route called");
    //   ProductModel popular = Get.parameters['product'] as ProductModel;
    //   print(popular.name);
    //   Get.
    //   return PopularFoodDetail();
    // },
    GetPage(name: popularFood, page: (){
      print("getPopularFood() route called");
      String? pageId = Get.parameters['pageId'];
      print("The pageId is: "+pageId.toString());

      return PopularFoodDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.downToUp,
    ),
    GetPage(name: recommendedFood, page: (){
      print("getRecommendedFood() route called");

      String? productId = Get.parameters['productId'];
      return RecommendedFoodDetail(productId: int.parse(productId!));
    },
      transition: Transition.downToUp,
    ),
    GetPage(name: cartPage, page: (){
      return Cartpage();
    },
    transition: Transition.fade,
    ),
    GetPage(name: splashScreen, page: (){
      return SplashScreen();
    },
      transition: Transition.fade,
    )
  ];
}