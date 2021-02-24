import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDayTime; // true if day and false if night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      //print(datetime);
      //(offset);

      //create DataTime object
      DateTime dateTime = DateTime.parse(datetime);
      //print(dateTime);
      dateTime = dateTime.add(Duration(
          hours: int.parse(offset.substring(1, 3)),
          minutes: int.parse(offset.substring(4))));

      isDayTime = dateTime.hour >= 6 && dateTime.hour < 18 ? true : false;
      time = DateFormat.jm().format(dateTime);
      //print(dateTime);
    } catch (e) {
      print('the error is: $e');
      time = 'could not get the time';
    }
  }
}
