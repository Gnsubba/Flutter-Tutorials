import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Icon icon;
  bool isObscure;
  AppTextField({Key? key, required this.textController, required this.hintText, required this.icon, this.isObscure=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,top: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: Dimensions.radius20/2,
                spreadRadius: Dimensions.raduis15/2,
                offset: Offset(1,10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObscure,
        controller: textController,
        decoration: InputDecoration(
          // hintText
          hintText: hintText,
          // prefixIcon
          prefixIcon: icon,
          // focusedIcon
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                color:  Colors.white,
                width: 1.0,
              )
          ),

          // enabled border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                color:  Colors.white,
                width: 1.0,
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),

          ),
        ),
      ),
    );
  }
}
