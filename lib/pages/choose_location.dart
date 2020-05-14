
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutterworldtime/services/world_time.dart';
import 'package:http/http.dart';


class Choose_Location extends StatefulWidget {
  @override
  _Choose_LocationState createState() => _Choose_LocationState();


}




class _Choose_LocationState extends State<Choose_Location> {

  int counter = 0;

  TextEditingController controller = new TextEditingController();

  List<World_Time> locations = [];

  List <World_Time> _searchResult=[];

  List <String> city;
  List <String> country;
  List <String> flag;

  List data_capital_city = [];

  List data_continent = [];

  Future <String> getData() async{

      var capital_city_json = await rootBundle.loadString("assets/capital_city.json");


      //data_capital_city.forEach((k,v) => k == 'country' ? country.add(v) : city.add(v));

      var continent_json = await rootBundle.loadString("assets/continent.json");



     setState(() {

       data_capital_city = json.decode(capital_city_json);


       data_continent = json.decode(continent_json);


       for(int i =0 ; i< data_continent.length;i++){

         String country = data_continent[i]['country'];

         for(int j =0 ; j< data_capital_city.length; j++){

           if(data_capital_city[j]['country'] == country){

             World_Time world_time = World_Time(url: data_continent[i]['continent']+'/'+data_capital_city[j]['capital']
                 , location: data_capital_city[j]['capital'], flag:data_capital_city[j]['country'].toLowerCase()+'.png');

             locations.add(world_time);

           }

         }




       }


     });




     print(data_capital_city);   }

      /*




       for(int i =0 ; i< data_continent.length;i++){

         String country = data_continent[i]['country'];

         for(int j =0 ; j< data_capital_city.length; j++){

           if(identical(data_capital_city[j]['country'],country)){

             World_Time world_time = World_Time(url: data_continent[j]['continent']+'/'+data_capital_city[j]['capital']
                 , location: data_capital_city[j]['capital'], flag: '//upload.wikimedia.org/wikipedia/commons/3/36/Flag_of_'
                     + data_capital_city[j]['country']+'.svg');

             locations.add(world_time);

           }

         }




       }


     });







      for(String c in country) {

        data_flag.forEach((k, v) => k == c ? flag.add(v): true );

      }

      for(int i =0;i<country.length;i++){

        World_Time world_time = World_Time(url: country[0]+'/'+city[0]+"", location: city[0]+"", flag: flag[0]+'.png');
        locations.add(world_time);

      }*/





   /* World_Time(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    World_Time(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    World_Time(url: 'Europe/Paris', location: 'Paris', flag: 'france.png'),
    World_Time(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    World_Time(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    World_Time(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    World_Time(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    World_Time(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    World_Time(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),*/






  void updatetime(BuildContext context,World_Time location) async{

    World_Time world_time = location;


    await world_time.getTime();

    if(world_time.isNotNull){

    Navigator.pop(context,  {


      'location' : world_time.location,

      'flag' : world_time.flag,

      'time' : world_time.time,

      'isDaytime' : world_time.isDaytime,

    } );}else{


      setState(() {

        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue[100],
          content: Text("Sorry time zone not found for this city",
            style:TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),),
        ));

      });


    }

  }

 /*

  void getData() async{

    String username = await Future.delayed(Duration(seconds: 3),(){

      return "Shimaa";

    });

    String bio = await Future.delayed(Duration(seconds: 2),(){

      return "Flutter developer";

    });


    print('$username - $bio');

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     Map<String, dynamic> dmap = await parseJsonFromAssets('assets/data_list.json');


  }


  */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   this.getData();

  }

  @override
  Widget build(BuildContext context) {

    print("initState");

    print(country);

    return Scaffold(


      backgroundColor: Colors.grey,
      appBar: AppBar(

        backgroundColor: Colors.blue,
        title: Text('Choose a location'),
        centerTitle: true,


      ),
      body: Column(


        children: <Widget>[
          Padding(
        padding: const EdgeInsets.all(0.0),
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search),
            title: new TextField(
              controller: controller,
              decoration: new InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },),
          ),
        ),),

          new Expanded(
          child: _searchResult.length != 0 || controller.text.isNotEmpty
          ? new ListView.builder(
          itemCount: _searchResult.length,
          itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Card(
            child: ListTile(

                onTap: () {

              updatetime(context,_searchResult[i]);

              },

              title: Text(_searchResult[i].location,
              style:TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              ),),
              leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/flags/${_searchResult[i].flag}'),
              radius: 30.0,
              ),
              ),
            margin: const EdgeInsets.all(0.0),
            ),
          );
          },
          )


              :new ListView.builder(
    itemCount: locations?.length ?? 0,
    itemBuilder: (context, index) {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(


            child: ListTile(

            onTap: () {

              updatetime(context,locations[index]);

            },

            title: Text(locations[index].location,
              style:TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/flags/${locations[index].flag}'),
                radius: 30.0,
              ),
            ),

            ),
    );
    }

            ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for(int i =0;i<locations.length;i++) {
      if (locations[i].location.toLowerCase().contains(text.toLowerCase())){
        _searchResult.add(locations[i]);}
    }

    setState(() {});

}}
