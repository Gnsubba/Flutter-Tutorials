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

class Tab1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/momo.png');
  }

}

class Tab2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/chowmein.png');
  }

}
class Tab3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/biryani.png');
  }

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Tabs"),
            ),
            body: TabBarView(children: [Tab1(), Tab2(), Tab3()]),
          bottomNavigationBar: Container(
            child: const TabBar(
              labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
              Tab(text: 'Cat #1', icon: Icon(Icons.keyboard_arrow_left)),
              Tab(text: 'Cat #2', icon: Icon(Icons.keyboard_arrow_up)),
              Tab(text: 'Cat #3', icon: Icon(Icons.keyboard_arrow_right))
            ]),
          ),
        ));
  }
}
