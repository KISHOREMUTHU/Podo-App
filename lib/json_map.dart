import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_app/post.dart';

class JsonMap extends StatefulWidget {
  @override
  _JsonMapState createState() => _JsonMapState();
}

class _JsonMapState extends State<JsonMap> {
  Future <postList> data;


  @override
  void initState() {
    super.initState();
    Network network = Network('https://jsonplaceholder.typicode.com/posts');
    data = network.loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar (
        title : Text ('PODO App'),

      ),
      body : Center (
        child : Container (
          child : FutureBuilder(
            future : data,
            builder : (context , AsyncSnapshot<postList> snapshot){
             List <Post> allPost;
             if(snapshot.hasData){
               allPost=snapshot.data.posts;
               return createListView(allPost,context);
             }
             else{
               return CircularProgressIndicator();
             }
            }
          ),
        ),
      ),
    );
  }
  Widget createListView(List <Post> data , BuildContext context){
    return Container (
      child : ListView.builder(
        itemCount : data.length,
        itemBuilder: (context, int index ){
          return Column(
            children : <Widget>[
              Divider(height :5.0),
              ListTile (
                title : Text('${data[index].title}'),
                subtitle : Text('${data[index].body}'),
                leading :Column(
                  children : <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius : 25,
                      child : Text('${data[index].id}'),
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
Future <postList> loadPost () async{
  Response response = await get(Uri.encodeFull(url));
  if(response .statusCode == 200){
    return postList.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to get posts ');
  }
}
}