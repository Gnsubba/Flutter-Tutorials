import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/account_widget.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF89dad0),
        centerTitle: true,
        title: BigText(text: "Profile", size: Dimensions.font26,),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            // profile icon
            Center(
              child: AppIcon(icon: Icons.person,iconSize: Dimensions.font20*4.5,backgroundColor: Color(0xFF89dad0),iconColor: Colors.white,size: Dimensions.font20*7.5,),
            ),
            SizedBox(height: Dimensions.height20,),
            // name
          Expanded(
            child: SingleChildScrollView(
               child: Column(
                children: [
                  AccountWidget(appIcon: AppIcon(icon:Icons.person, iconSize:Dimensions.height10*2.5, backgroundColor: Color(0xFF89dad0),iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: 'Ganesh',)),
                  SizedBox(height: Dimensions.height20,),
                  // phone
                  AccountWidget(appIcon: AppIcon(icon:Icons.phone, iconSize:Dimensions.height10*2.5, backgroundColor: Colors.orangeAccent,iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: '9842253467',)),
                  SizedBox(height: Dimensions.height20,),
                  // email
                  AccountWidget(appIcon: AppIcon(icon:Icons.email, iconSize:Dimensions.height10*2.5, backgroundColor: Colors.orangeAccent,iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: 'ganesh@email.com',)),
                  SizedBox(height: Dimensions.height20,),
                  // address
                  AccountWidget(appIcon: AppIcon(icon:Icons.location_on, iconSize:Dimensions.height10*2.5, backgroundColor: Colors.orangeAccent,iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: 'Lalitpur',)),
                  SizedBox(height: Dimensions.height20,),
                  // message
                  AccountWidget(appIcon: AppIcon(icon:Icons.message_outlined, iconSize:Dimensions.height10*2.5, backgroundColor: Colors.redAccent,iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: 'Hello',)),
                  SizedBox(height: Dimensions.height20,),
                  // message
                  AccountWidget(appIcon: AppIcon(icon:Icons.message_outlined, iconSize:Dimensions.height10*2.5, backgroundColor: Colors.redAccent,iconColor: Colors.white,size: Dimensions.font20*2.5), bigText: BigText(text: 'Hello',)),

                ],
              ),
            ),
          )  
          ],
        ),
      ),
    );
  }
}
