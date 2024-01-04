import 'dart:convert';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print("The isDayTime in data is: "+data['isDayTime'].toString());
    String bgImage = data['isDayTime'] ? 'night.jpeg' : 'day.png';
    Color? bgColor = data['isDayTime'] ? Colors.indigo[700] : Colors.blue;

    return  Scaffold(
      // appBar: AppBar(
      //   title: Text("World Time App"),
      //   centerTitle: true,
      // ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/$bgImage'),fit: BoxFit.cover)),
          child: Column(
          children: [
            SizedBox(height: 20.0,),
            IconButton(onPressed: () async {
              print("CLicked on button");
              dynamic result = await Navigator.pushNamed(context, '/choose_location');
              print(result);
              setState(() {
                data = {
                  'time': result['time'],
                  'location': result['location'],
                  'isDayTime' : result['isDayTime'],
                  'flag': result['flag']
                };
              });
            }, icon: Icon(Icons.edit_location),color: Colors.grey[100],),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['location'],style: TextStyle(
                  fontSize: 26.0,
                  letterSpacing: 2.0,
                ),),

              ],
            ),
            SizedBox(height: 20.0,),
            Text(data['time'],style: TextStyle(
              fontSize: 66.0,
            ),),
          ],
        ),),
      ),


    );
  }
}
