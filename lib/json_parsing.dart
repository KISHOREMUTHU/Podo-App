import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class JSONParsing extends StatefulWidget {
  @override
  _JSONParsingState createState() => _JSONParsingState();
}

class _JSONParsingState extends State<JSONParsing> {
  Future data ;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text('JSON App '),
      ),
      body : Center(
        child : Container (
          child : FutureBuilder(
            future : getData(),
            builder :(context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
              return createListView(snapshot.data, context );
              }
              else {
                return CircularProgressIndicator(

                );

              }
            }
          ),
        ),
      ),
    );
  }

  Future getData ( ) async {
     var  data ;
     String url = 'https://jsonplaceholder.typicode.com/posts';
     Network network = Network(url);
     data = network.fetchData();
     return data;
   /*  data.then((value)  {
     print (value[0]['title']);

     });*/
                           }

  Widget createListView(List data, BuildContext context) {

    return Container(
      child : ListView.builder(
        itemCount : data.length,
        itemBuilder: (context , int index ){
          return Column(
            mainAxisAlignment : MainAxisAlignment.center ,
            children : <Widget> [
              Divider (height: 5.0,),
              ListTile (
                title : Text('${data[index]["title"]}'),
              subtitle : Text( '${data[index]['body']}'),
                leading : Column (
                  children : <Widget> [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius : 23 ,
                      child : Text ( '${data[index]['id']}'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

  }
}

class Network{
  final String url  ;

  Network ( this.url);
  Future fetchData() async{
     print('$url');
     Response response = await get(Uri.encodeFull(url));
     if ( response. statusCode == 200){
      // print(response.body);
       return json.decode(response.body);
     }
     else{
       print(response.statusCode);
     }
  }

}