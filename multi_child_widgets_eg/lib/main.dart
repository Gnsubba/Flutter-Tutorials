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
  bool stack_val = false;

  void _incrementCounter() {
    if(!stack_val) {
      setState(() {
        _counter++;
      });
    }
  }
  void loading(){
    setState((){
      stack_val = stack_val?false:true;
    });

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> wg_ls = [
      ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          const Center(child: Text("Scrolling", style: TextStyle(fontSize: 50),), widthFactor: 2.0,)
        ],
      ),
      const Center(child: Image(image: AssetImage('assets/loading.gif')))
    ];
    List<Widget> stacklist = [];

    if (stack_val == true){
      stacklist = wg_ls;
    }
    else{
      stacklist = [];
      stacklist.add(wg_ls[0]);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(children: stacklist

        ,),
      ),
      floatingActionButton: Row(

          children: [
            Expanded(
              child: FloatingActionButton(
                  onPressed: loading,
                  tooltip: 'Loading',
                  child: const Icon(Icons.accessibility_new_rounded),
                ),
            ),

            Expanded(
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ]

        ),
      
    );
  }
}
