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
      home: PersonInheritedWidget(child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class Person{
  String _name;
  String _email;
  int _age;

  Person(this._name, this._email, this._age);

}

class PersonInheritedWidget extends InheritedWidget{
  PersonInheritedWidget(child):super(child: child);

  List<Person> persons = [
    Person("Ganesh", "ganesh@email.com", 24),
    Person("Anish", "anish@email.com", 23),
    Person("Sagar", "sagar@email.com", 24)
  ];

  void addPerson(String name, String email, int age){
    persons.add(Person(name, email, age));
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static InheritedElement? of(BuildContext context){
    return (context.);
  }

}

class MyHomePage extends StatelessWidget {


  MyHomePage({ required this.title}) : super();

  String title;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList =
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: widgetList
        ),
      ),
    );
  }


}


