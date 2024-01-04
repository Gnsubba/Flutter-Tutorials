import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/5.63;


  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt(),widget.text.length);
    }
    else{
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(height: 1.5, text: firstHalf,size: Dimensions.font16,color: Colors.black87,):Container(
        child: Column(
          children: [
            SmallText(height: 1.5, text: hiddenText?(firstHalf+'...'):(firstHalf+secondHalf),size: Dimensions.font16,color: Colors.black87,),
            InkWell(
              onTap: (){
                setState(() {
                  hiddenText=!hiddenText;
                });
              },
              child: Row(
                children: [
                  SmallText(text: hiddenText?"Show more":"Show less", color: Color(0xFF89dad0,),),
                  Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: Color(0xFF89dad0),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
