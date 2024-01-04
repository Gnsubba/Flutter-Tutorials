import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  late bool isDayTime; // true or false if daytime or not
  late String location; // Location name for the ui
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String endpoint;
  late String apiUrl = 'http://worldtimeapi.org/api/timezone/$endpoint'; // Api url

  WorldTime({ required this.endpoint, required this.location, required this.flag});

  Future<void>  getTime() async{
    print("Getting the response from the api");
    try {
      print("The api url is: "+apiUrl);
      Response response = await get(Uri.parse(apiUrl));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // print(datetime);
      // print(offset);
      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      print("This is the offset: "+offset);
      // now = now.add(Duration(hours: int.parse(offset)));
      print(now);
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      print("The isDayTime is: "+isDayTime.toString());
      // set the time property
      time = DateFormat.jm().format(now);
      print("The time is: "+time.toString());
    }catch(err){
      print(err);
    }

  }

}