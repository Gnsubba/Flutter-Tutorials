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
      theme: ThemeData(accentColor: Colors.redAccent,
        brightness: Brightness.dark
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
  String log = '';

  void _clear() {
    setState(() {
      log = "";
    });
  }

  void _logGesture(String text){
    setState(() {
      log += '\n$text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Text("Gesture me", style: TextStyle(fontSize: 20.0),),
                onTap: ()=>_logGesture('tap'),
                onTapDown: (details) => _logGesture('onTapDown: ${details}'), onTapUp: (details) => _logGesture('onTapUp: ${details}'), onTapCancel: () => _logGesture('onTapCancel'),
                onDoubleTap: () => _logGesture('onDoubleTap'),
                onLongPress: () => _logGesture('onLongPress'), onVerticalDragDown: (details) =>
                _logGesture('onVerticalDragDown: ${details}'), onVerticalDragStart: (details) =>
                _logGesture('onVerticalDragStart: ${details}'), onVerticalDragUpdate: (details) =>
                _logGesture('onVerticalDragUpdate'), onVerticalDragEnd: (details) =>
                _logGesture('onVerticalDragEnd: ${details}'), onVerticalDragCancel: () =>
                _logGesture('onVerticalDragCancel'), onHorizontalDragDown: (details) =>
                _logGesture('onHorizontalDragDown: ${details}'), onHorizontalDragStart: (details) =>
                _logGesture('onHorizontalDragStart: ${details}'), onHorizontalDragUpdate: (details) =>
                _logGesture('onHorizontalDragUpdate: ${details}'), onHorizontalDragEnd: (details) =>
              _logGesture('onHorizontalDragEnd: ${details}'), onHorizontalDragCancel: () =>
              _logGesture('onHorizontalDragCancel'
              )
              ),
            ),
            Expanded(
              child: Container(
                  child:
                  SingleChildScrollView(child: Text('$log')), constraints: BoxConstraints(maxHeight: 200.0), decoration: BoxDecoration(
                  border: Border.all( color: Colors.grey, width: 1.0,
                  )),
                  margin: const EdgeInsets.all(10.0), padding: const EdgeInsets.all(10.0)),
            ),
            Expanded(child: FloatingActionButton(child: const Text('Clear'), onPressed: () => _clear()))
          ],
        ),
      ),
      drawer: Column(
        children: [
          Padding(padding: const EdgeInsets.only(left:30, top: 120, bottom: 20),child: TextButton(onPressed: ()=>{}, child: const Text("Home", style: TextStyle(fontSize: 30),)))
        ],
      ),
      persistentFooterButtons: [
        IconButton(onPressed: () => {print("Back arrow icon clicked from persistentFooterButtons")}, icon: const Icon(Icons.arrow_back, size: 20.0,))
      ],
      bottomSheet: const Text("Beta Version", style: TextStyle(fontSize: 20),),
    );
  }
}
