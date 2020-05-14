import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

/*

*/


class World_Time{


String location;
String city;
String time;
String url;
String flag;
bool isDaytime;

bool isNotNull;

World_Time({this.location,this.flag,this.url});

Future <void> getTime() async{

try{


  http.Response response = await http.get('http://worldtimeapi.org/api/timezone/$url');

  final r = await http.get('http://worldtimeapi.org/api/timezone/$url');

  if (r.statusCode == 200) {

    isNotNull=true;

  } else {

    isNotNull=false;

  }

  Map data = jsonDecode(response.body);

  String datetime = data['datetime'];

  String offset = data['utc_offset'].substring(1,3);

  DateTime now = DateTime.parse(datetime);

  now = now.add(Duration(hours: int.parse(offset)));

  /*print(datetime);
  print(now);
  print(offset);*/

  time = DateFormat.jm().format(now);


  isDaytime= now.hour > 6 && now.hour <20 ? true : false;



}catch(e){

  print(e);
  time = 'Oops, something went wrong :(';



}

}




}





