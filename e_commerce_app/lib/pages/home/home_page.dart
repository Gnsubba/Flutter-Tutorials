import 'package:e_commerce_app/pages/account/account_page.dart';
import 'package:e_commerce_app/pages/auth/sign_up_page.dart';
import 'package:e_commerce_app/pages/cart/cart_list.dart';
import 'package:e_commerce_app/pages/cart/cart_page.dart';
import 'package:e_commerce_app/pages/home/main_food)page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  int _index=0;
  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("Next Page"),),),
    Container(child: Center(child: Text("Next next next Page"),),),
    // Cartpage(),
    AccountPage()
  ];

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      Container(child: Center(child: Text("Next Page"),)),
      // Cartpage(),
      CartListPage(),
      AccountPage()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }
  void onTapNav(int index){
    setState(() {
      _index = index;
    });
  }

  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _loadResources();
    _controller = PersistentTabController(initialIndex: 0);
  }
  // @override
  // Widget build(BuildContext context) {

    // return Scaffold(
    //   body: pages[_index],

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _index,
      //   onTap: onTapNav,
      //   items: [
      //   BottomNavigationBarItem(icon: Icon(Icons.home_outlined,),label: 'Home',),
      //   BottomNavigationBarItem(icon: Icon(Icons.archive,),label: 'History'),
      //   BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,),label: 'Home'),
      //   BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Profile'),
      //
      //   ],
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.black54,
      // ),
      // bottomNavigationBar: ,
    // );

  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }
}
