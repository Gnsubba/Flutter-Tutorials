import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  Map<String, dynamic> ganesh = {
    'name': "Ganesh",
    'age': 24,
    'address': 'Satdobato'
  };
  print(ganesh['name']);


  runApp(const MyApp());
}

class Person{
  String _name;
  String _age;



  String _address;

  Person(this._name, this._age, this._address);

  Map<String, dynamic> toJson(){

    return {
      'name':_name,
    'age': _age,
    'address': _address
  };
  }

  factory Person.fromJson(Map<String, dynamic> val){
    return Person(val['name'], val['age'], val['address']);
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _dataExists = false;
  String text = '';
  static const TIMEOUT = Duration(seconds: 10);
  void _request() async{
    String res = await _getEmployees();
    print(res);
    setState(() {
      text = res;
    });
  }

  Future<String> _getEmployees() async{

    try {
      var client = http.Client();
      print("Client Created");
      http.Response response = await client.get(
          'https://dummy.restapiexample.com/api/v1/employees').timeout(TIMEOUT);
      print("Request was sent");
      if(response.statusCode==200){
        print(response.body);
      }
      else{
        badStatusCode(response);
      }

    }
    on Exception catch(err){
      print(err);
    }
    throw Exception();
  }


  badStatusCode(http.Response response) {
    debugPrint("Bad status code ${response.statusCode} returned from server.");
    debugPrint("Response body ${response.body} returned from server.");
    throw Exception(
        'Bad status code ${response.statusCode} returned from server.'
    );
  }
  
  @override
  Widget build(BuildContext context) {

    List<Widget> widgetList = [];
    widgetList.add(_createInputTextField());
    widgetList.add(_createConvertButton());
    widgetList.add(Text(text));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(child: Column(
        children: widgetList,
      ),) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _createInputTextField() {
    return TextFormField(
      maxLines: 8,
      onChanged: (data)=>_onchange(data),
    );
  }

  Widget _createConvertButton(){
    return OutlinedButton(onPressed: _dataExists?()=>_request():null, child: const Text('Request'));
  }

  _onchange(String data) {
    setState(() {
      _dataExists = true;
    });
  }
}
