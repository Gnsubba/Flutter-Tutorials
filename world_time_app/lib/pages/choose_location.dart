import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {


  List<WorldTime> locations = [
    WorldTime(endpoint: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(endpoint: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(endpoint: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(endpoint: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(endpoint: 'Asia/Kathmandu', location: 'Kathmandu', flag: 'nepal.png')
  ];
  // int counter = 0;
  //
  // void getData() async{
  //
  //   // simulate network request for a username
  //   String username = await Future.delayed(Duration(seconds: 3),(){
  //     return "Yoshi";
  //   });
  //
  //   // simulate network request to get bio of the username
  //   String login = await Future.delayed(Duration(seconds: 2),(){
  //     return "$username logged in.";
  //   });
  //
  //   print(login);
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getData();
  //   print("initState function ran");
  // }

  Future<void> updateTime(index) async {
    WorldTime instance = WorldTime(endpoint: locations[index].endpoint, location: locations[index].location, flag: locations[index].flag);
    await instance.getTime();
    // Navigate to home screen
    Navigator.pop(context,{"location":instance.location,"flag":instance.flag ,"time":instance.time,"isDayTime":instance.isDayTime});
  }

  @override
  Widget build(BuildContext context) {
    print("build function ran");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Choose a Location"),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.blue[200],
      ),
      // body: TextButton(onPressed: (){
      //   setState(() {
      //     counter += 1;
      //   });
      // },
      // child: Text("Counter is $counter"),
      body: ListView.builder(itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/${locations[index].flag}'),radius: 25.0,),
              ),
            ),
          );
        },),
    );
  }
}
