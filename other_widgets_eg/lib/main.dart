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
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool exit = false;

  Future<bool> _showConfirmDialog() async {
    return await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text("Confirm"),
        content: Text("Are you sure you want to increment the counter?"),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context, true);}, child: const Text("Yes")),
          TextButton(onPressed: (){Navigator.pop(context, false);}, child: const Text("No"))
        ],
        );
    });
  }

  void _incrementCounter() {
    _showConfirmDialog().then((value){if (value==true) {
      setState(() {
        _counter++;
        s
      });
    }
    });

  }


  @override
  Widget build(BuildContext context) {
    bool married = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              Padding(padding: EdgeInsets.only(right: 40.0), child: Text("Married", style: TextStyle(fontSize: 30.0),)),
              Checkbox(value: false, onChanged: (val)=>{
                !val!
              })
            ]),

            const Text(
              'You have pushed the button this many times:',
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Is married: $married',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
