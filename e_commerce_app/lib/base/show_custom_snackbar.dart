import 'dart:ui';

import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,{bool isError=true, String title='Error'}){
  Get.snackbar(title, message,backgroundColor: Colors.redAccent,
      titleText: BigText(text: title, color: Colors.white,),
    messageText: Text(message,style: const TextStyle(
      color: Colors.white
    ),),
    snackPosition: SnackPosition.TOP,
  );
}