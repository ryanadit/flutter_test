import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_test_app/User.dart';

void main() {
  runApp(new MaterialApp(
    title: "My Apps",
    home: new HalamanJson(),
  ));
}

class HalamanJson extends StatefulWidget {
  @override
  _HalamanJsonState createState() => _HalamanJsonState();
}

class _HalamanJsonState extends State {
  List datadariJSON;


  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/todos"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      datadariJSON = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data JSON"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: datadariJSON == null ? 0 : datadariJSON.length,
            itemBuilder: (context, i){
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("UserId : "+
                          datadariJSON[i]['userId'].toString(),
                          style: Theme.of(context).textTheme.title,
                        ),

                        Text("Title : "+datadariJSON[i]['title']),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => HalamanJsonDetail(userId :datadariJSON[i]['id'])));
                              },
                              child: Text(
                                "View",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
//              return ListTile(
//                title: Text(datadariJSON[i]['title']),
//              );
            }
        ),
      ),
    );
  }
}


class HalamanJsonDetail extends StatefulWidget {
  final int userId;
  HalamanJsonDetail({
    Key key,
    @required this.userId
}):super(key:key);

  @override
  _HalamanJsonDetailState createState() => _HalamanJsonDetailState(userId : userId);
}

class _HalamanJsonDetailState extends State{

  String user_id = "",Id = "",Title ="";
  final int userId;
  _HalamanJsonDetailState({
    @required this.userId
}):super();


  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/todos/"+userId.toString()),
        headers: {"Accept": "application/json"});

    this.setState(() {
      var data = jsonDecode(hasil.body);
      var jsonData = User.fromJson(data);
      user_id = jsonData.userId.toString();
      Id = jsonData.id.toString();
      Title = jsonData.title;

    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dtail "+userId.toString()),
        ),
      body: Container(
        child: ListView.builder(
          itemCount: 1,
            itemBuilder: (context,i){
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("User id : "+
                            user_id,
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text("ID : "+Id),
                        Text("Title : "+Title)

                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );

  }


  
}