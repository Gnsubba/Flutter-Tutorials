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
      title: 'Exercise 1',
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
      home: const MyHomePage(title: 'HOME '),

    );
  }
}

class MyHomePage extends StatelessWidget{

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold( appBar: AppBar(title: Text(title),),
      body: ListView(children: const <Widget>[
        CarWidget("Bmw", "M3",
            "https://media.ed.edmunds-media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg"),
        CarWidget("Nissan", "GTR",
            "https://media.ed.edmunds-media.com/nissan/gt-r/2018/oem/2018_nissan_gt-r_coupe_nismo_fq_oem_1_150.jpg"),
        CarWidget("Nissan", "Sentra",
            "https://media.ed.edmunds-media.com/nissan/sentra/2017/oem/2017_nissan_sentra_sedan_sr-turbo_fq_oem_4_150.jpg"),
      ]));
    throw UnimplementedError();
  }

}


class CarWidget extends StatelessWidget {
  const CarWidget(this.make, this.model, this.imageSrc, {super.key});
  final String make; final String model; final String imageSrc;
  @override
  Widget build(BuildContext context) {
    print(imageSrc);
    return Padding(padding: EdgeInsets.all(20.0),child: Center(
        child: Container(padding: EdgeInsets.all((20.0)),decoration: BoxDecoration(border: Border.all()),
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: 10.0), child:Text("${make} ${model}", style: TextStyle(fontSize: 24.0))),
        const Image(image: NetworkImage('https://picsum.photos/250?image=9',), )
      ])),),
    );
  }
}