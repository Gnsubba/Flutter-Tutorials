import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/app_icon.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20, bottom:Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width30,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          offset: Offset(0,2),
          color: Colors.grey.withOpacity(0.2)
        )
    ]
      ),
    );
  }
}
