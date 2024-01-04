import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: text,size: Dimensions.font26,),
          SizedBox(height: Dimensions.height10,),
          Row(
            children: [
              Wrap(
                children: List.generate(5, (index) => Icon(Icons.star,color: Color(0xFF89dad0),size: 15,)),
              ),
              SizedBox(width: Dimensions.width10,),
              SmallText(text: '4.5',size: 14,),
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
    );
  }
}
