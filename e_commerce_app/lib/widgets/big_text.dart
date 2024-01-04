
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;
  const BigText({Key? key, this.color = const Color(0xFF332d2b), required this.text, this
  .overflow = TextOverflow.ellipsis, this.size = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size==0?Dimensions.font20:size,
        fontWeight: FontWeight.w400
      ),
    );
  }
}
