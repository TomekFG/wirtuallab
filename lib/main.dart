import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'classes.dart';
import 'LISTA_STANOWISK.dart';


void main() {
  //runApp(MyApp());
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MAIN_APP(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future data;
  String url = "https://jsonplaceholder.typicode.com/posts";
  String dropdownValue = "POST";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Parsing JSON"),
        ),
        body: Column(
            children: <Widget>[
              Expanded(flex:1,child: choiceList()),
              Expanded(flex:14,child: FutureBuilder(
                  future: getData(),
                  builder: (context, AsyncSnapshot snapshot){

                    if(snapshot.hasData && dropdownValue == "POST") {
                      return createListViewPOST(snapshot.data, context);
                    }

                    else if(snapshot.hasData && dropdownValue == "USERS"){
                      return createListViewUSERS(snapshot.data, context);
                    }

                    else{
                      return CircularProgressIndicator();
                    }
                  }
              ))
            ]
        )



    );
  }

  Future getData() async{

    if(dropdownValue == "POST"){ url = "https://jsonplaceholder.typicode.com/posts";}
    else if (dropdownValue == "USERS"){ url = "https://jsonplaceholder.typicode.com/users";}

    var data;

    //String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();

    return data;
  }

  Widget createListViewPOST(List data, BuildContext context){
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 50.0,
              columns: [
                DataColumn(label: Text(
                  'ID',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                  'VALUE',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),
                DataColumn(label: Text(
                  'BODY',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )),
              ],
              rows: data.map((e){
                return DataRow(cells:[
                  DataCell(Text(e["id"].toString())),
                  DataCell(Text(e["title"])),
                  DataCell(Text(e["body"].toString())),
                ]);
              }).toList(),

            )));

  }

  Widget createListViewUSERS(List data, BuildContext context){
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(
                  'ID',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                )),
                DataColumn(label: Text(
                  'NAME',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                )),
                DataColumn(label: Text(
                  'EMAIL',
                  //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                )),
              ],
              rows: data.map((e){
                return DataRow(cells:[
                  DataCell(Text(e["id"].toString())),
                  DataCell(Text(e["name"])),
                  DataCell(Text(e["email"].toString())),
                ]);
              }).toList(),

            )));
  }

  Widget choiceList() {
    //List Sensors = ["WSZYSTKIE", "CZUJNIK 1", "CZUJNIK 2", "CZUJNIK 3"];

    return DropdownButton<String>(
      value: dropdownValue,
      //icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>["POST", "USERS"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print("$url");
    http.Response response;
    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return json.decode(response.body);
    }

    else {
      print(response.statusCode);
    }
  }
}


