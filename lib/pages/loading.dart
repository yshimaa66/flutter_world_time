import 'package:flutter/material.dart';
import 'package:flutterworldtime/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

   //String time='loading';

  Map data = {};



  void setup_worldtime() async{

    World_Time world_time = new World_Time(location :'Berlin',flag:'germany.png',url:'Europe/Berlin' );


    await world_time.getTime();


    data = ModalRoute.of(context).settings.arguments;



    Navigator.pushReplacementNamed(context, '/home', arguments: {



      'location' : world_time.location,

      'flag' : world_time.flag,

      'time' : world_time.time,

      'isDaytime' : world_time.isDaytime,



    });


    //print(world_time.time);

    /*setState(() {

      time = world_time.time;

    });*/

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setup_worldtime();
    print("Hi, there");

  }


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(

      backgroundColor: Colors.blue,

      body: Center(

         child: SpinKitDoubleBounce(
           color: Colors.white,
           size: 80.0,
         ),



      )


    );
  }
}