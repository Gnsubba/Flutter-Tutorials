import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:world_time_app/services/world_time.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  // String time = 'Loading';
  // void  getData() async{
  //   print("Getting the response from the api");
  //   Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kathmandu'));
  //   Map data = jsonDecode(response.body);
  //   print(data);
  // }
  void setUpWorldTime() async {
    WorldTime instance = WorldTime(location: 'Kathmandu', flag: 'Nepal.png',endpoint: 'Asia/Kathmandu');
    await Future.delayed(Duration(seconds: 2),(){
      print("Starting the app");
    });
    await instance.getTime();
    try {
      // print(instance.time);
      // setState(() {
      //   time = instance.time;
      // });
      Navigator.pushReplacementNamed(context, '/home',arguments: {"location":instance.location,"flag":instance.flag ,"time":instance.time,"isDayTime":instance.isDayTime});

    }
    catch(err){
      print(err);
      // setState(() {
      //   time = "couldn`t get time data";
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpWorldTime();
    print("initState ran.");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Padding(
      //   padding: EdgeInsets.all(50.0),
      //
      // ),
      backgroundColor: Colors.blue[400],
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
