import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

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




class Stanowisko{
  int staId;
  String staNazwa;
  String staOpis;

  Stanowisko({
    required this.staId,
    required this.staNazwa,
    required this.staOpis});

  factory Stanowisko.fromJson(Map<String, dynamic> json){
    return Stanowisko(
        staId: json['staId'],
        staNazwa: json['staNazwa'],
        staOpis: json['staOpis'],
    );

  }
}

class Czujnik {
  final int czuId;
  final String czuNazwa;

  Czujnik({
    required this.czuId,
    required this.czuNazwa,
  });

  factory Czujnik.fromJson(Map<String, dynamic> json) {
    return Czujnik(
      czuId: json["czuId"],
      czuNazwa: json["czuNazwa"],
    );
  }
}

class Pomiar {
  final int zapId;
  final String zapCzas;
  final String zapOpis;
  final int zapWartosc;


  Pomiar({
    required this.zapId,
    required this.zapCzas,
    required this.zapOpis,
    required this.zapWartosc,
  });

  factory Pomiar.fromJson(Map<String, dynamic> json) {
    return Pomiar(
      zapId: json["zapId"],
      zapCzas: json["zapCzas"],
      zapOpis: json["zapOpis"],
      zapWartosc: json["zapWartosc"],
    );
  }
}