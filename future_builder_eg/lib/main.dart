import 'package:flutter/material.dart';

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

  String computeListOfTimestamps(int count){
    StringBuffer stringBuffer = StringBuffer();
    for (int i=0; i<count;i++){
      stringBuffer.writeln("${i+1}: ${DateTime.now()}");
    }
    return stringBuffer.toString();
  }

  Future<String> createFutureCalculations(int count){
    return Future(() => computeListOfTimestamps(count));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCalculation = false;


  void _onInvokeFuturePressed() {
    setState(() {
      _showCalculation = !_showCalculation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _showCalculation ? FutureBuilder(
      future: widget.createFutureCalculations(1000),
      builder: (BuildContext context, AsyncSnapshot snapshot){
          return Expanded(child: SingleChildScrollView(
            child: Text(snapshot.data==null?"":snapshot.data,style: TextStyle(fontSize: 20.0), ),
          ));
    }):const Text('hit the button to show calculation');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[child
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onInvokeFuturePressed,
        tooltip: 'Invoke future',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
