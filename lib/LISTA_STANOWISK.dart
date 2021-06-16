import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MAIN_APP extends StatefulWidget{
  MAIN_APP_PAGE createState()=> MAIN_APP_PAGE();
}

class MAIN_APP_PAGE extends State<MAIN_APP>{

  late Future data_czujnik;
  late Future data_stanowisko;
  String? selectedStanowisko;
  String? selectedCzujnik;
  bool ignoring = true;


  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

  Future getData_stanowisko() async{

    Future data;
    String url_choose_stanowisko = "http://25.60.95.70:8080/SQL/allStations";

    Network network = Network(url_choose_stanowisko);

    data = network.fetchData();

    return data;
  }

  Future getData_czujnik() async{

    Future data;
    String url_choose_czujnik = "http://25.60.95.70:8080/SQL/allDevices";
    late String cutID;

    if(selectedStanowisko != null) {
      cutID = selectedStanowisko![0];
      url_choose_czujnik = "http://25.60.95.70:8080/SQL/deviceByStationID?id=${cutID}";
    }

    Network network = Network(url_choose_czujnik);

    data = network.fetchData();

    return data;
  }

  Future getData() async{

    Future data;
    late String url = "http://25.60.95.70:8080/SQL/allReadings";
    late String cutID;

    if(selectedCzujnik != null) {
      cutID = selectedCzujnik![0];
      url = "http://25.60.95.70:8080/SQL/readingByDeviceId?id=${cutID}";
    }

    //String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();

    return data;
  }

  postData(id, czuID, czas, opis, wartosc) async{
    var url = "http://25.60.95.70:8080/addReading";

    var response = await http.post(
      Uri.parse(url),
      body:{
        "zapId":id.toString(),
        "czuId":czuID.toString(),
        "zapCzas":czas.toString(),
        "zapOpis":opis.toString(),
        "zapWartosc":wartosc.toString()
      });

    print(response.body);

  }



  @override
  void initState() {
    super.initState();
    //returnList();
    //data_stanowisko = getData_stanowisko();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Center(child:Text('WIRTUALNE LABORATORIUM')),
          actions: [ButtonAll(), AddReading()]),
        body: Column(
            children: <Widget>[

              Stations(),
              Devices(),
              Readings(),



        ]));
  }


  Widget chooseStanowisko(List data, BuildContext context){

    return DropdownButton<String>(
      hint: Text("wybierz stanowisko"),
      value: selectedStanowisko,
      onChanged: (String? newValue) {
        setState(() {
          if(selectedStanowisko == null)
            setIgnoring(!this.ignoring);
          else if(selectedStanowisko != newValue)
            selectedCzujnik = null;
          selectedStanowisko = newValue!;
        });
        print(selectedStanowisko);
      },
      items: data.map((e) {
        return new DropdownMenuItem<String>(
          value: e["staId"].toString() + ". " + e["staNazwa"].toString(),
          child: new Text(e["staId"].toString() + ". " + e["staNazwa"].toString(),
              style: new TextStyle(color: Colors.black)),
        );
      }).toList(),
    );

  }

  Widget chooseCzujnik(List data, BuildContext context){

    return DropdownButton<String>(
      hint: Text("wybierz czujnik"),
      value: selectedCzujnik,
      onChanged: (String? newValue) {
        setState(() {
          selectedCzujnik = newValue!;
        });
        print(selectedCzujnik);
      },
      items: data.map((e) {
        return new DropdownMenuItem<String>(
          value: e["czuId"].toString() + ". " + e["czuNazwa"].toString(),
          child: new Text(e["czuId"].toString() + ". " + e["czuNazwa"].toString(),
              style: new TextStyle(color: Colors.black)),
        );
      }).toList(),
    );

  }

  Widget createListView(List data, BuildContext context){

    if(data.length == 0){
      return Text("BRAK POMIARÓW");
    }

    else {
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
                    'DATA',
                    //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                  )),
                  DataColumn(label: Text(
                    'WARTOŚĆ',
                    //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                  )),
                  DataColumn(label: Text(
                    'OPIS',
                    //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[200])
                  )),
                ],
                rows: data.map((e) {
                  return DataRow(cells: [
                    DataCell(Text(e["zapId"].toString())),
                    DataCell(Text(e["zapCzas"])),
                    DataCell(Text(e["zapWartosc"].toString())),
                    DataCell(Text(e["zapOpis"].toString())),
                  ]);
                }).toList(),

              )));
    }
  }

  Widget Stations(){
    return FutureBuilder(
            future: getData_stanowisko(),
            builder: (context, AsyncSnapshot snapshot){
            return chooseStanowisko(snapshot.data, context);
            }
    );
  }

  Widget Devices(){
    return Center(child: new IgnorePointer(
            ignoring: ignoring,
            child:
              FutureBuilder(
                future: getData_czujnik(),
                builder: (context, AsyncSnapshot snapshot){
                return chooseCzujnik(snapshot.data, context);
            }
        )));
  }

  Widget Readings(){
    return Center(child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot){

            if(selectedStanowisko != null && selectedCzujnik == null)
                return Text("NAJPIERW WYBIERZ CZUJNIK");


              else
                return createListView(snapshot.data, context);
            }
    ));
  }

  Widget ButtonAll(){
    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: () {
        setState(() {
          selectedStanowisko = null;
          selectedCzujnik = null;
        });
      },
    );
  }

  Widget AddReading(){
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed:(){} //postData(10, 1, "2021-12-12", "test Michał", 100)

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













