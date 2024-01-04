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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Text Color'),
    );
  }
}

class TextColor{

  late Color color;
  late String text;

  TextColor(this.color, this.text);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<TextColor> textColors = [
    TextColor(Colors.red, 'every'),
    TextColor(Colors.redAccent, ' schoolboy'),
    TextColor(Colors.green, '\nknows'),
    TextColor(Colors.greenAccent, ' who'),
    TextColor(Colors.blue, '\nimprisoned'),
    TextColor(Colors.blueAccent, '\nMontezuma')
  ];

  void _incrementCounter() {
    if (_counter + 1 < textColors.length) {
      setState(() {
        _counter++;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    print("Build method called");
    List<Text> textList = [];
    for(int i=0; i<_counter+1;i++){
      textList.add(Text(textColors[i].text, style: TextStyle(color: textColors[i].color),));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: textList
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Next',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
