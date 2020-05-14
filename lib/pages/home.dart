import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    print(data);

    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';

    return Scaffold(

      body: Builder(
        builder: (context) =>

            Container(

            decoration: BoxDecoration(

            image: DecorationImage(

              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
                 )

            ),

            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,50.0,0,0),
                child: Column(

                children: <Widget>[

                FlatButton.icon(
                    onPressed: () async {

                      dynamic result = await Navigator.pushNamed(context, '/location');

                      setState(() {

                        data={

                          'location' : result['location'],

                          'flag' : result['flag'],

                          'time' : result['time'],

                          'isDaytime' : result['isDaytime'],

                        };

                      });

                    },
                  icon: Icon(Icons.edit_location,
                  size: 20.0,
                  color: Colors.white,),
                  label: Text('Edit Location',
                    style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),

                  )),

                  SizedBox(height: 150.0,),
                  Text(data['location'],
                    style:TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20.0,),

                  Text(data['time'],
                    style:TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),

    ],
    ),
              ),
            ),

      ),
      ),


    );

  }
}
