import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
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

class Customer{
  Customer(this._firstName, this._lastName){
    _upButton = false;
    _downButton = false;
  };

  final String _firstName;
  final String _lastName;
  late bool _upButton;
  late bool _downButton;

  String get name{
    return _firstName + _lastName;
  }

  bool get downButton{
    return _downButton;
  }

  bool get upButton{
    return _upButton;
  }

  @override
  operator ==(other) =>
      (other is Customer) &&
          (_firstName == other._firstName) && (_lastName == other._lastName);

  @override
  int get hashCode => _firstName.hashCode ^ _lastName.hashCode;
}

class Bloc{

  // Bloc stands for Business Logic Component

  List<Customer> customerList = [];


}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),

    );
  }
}
