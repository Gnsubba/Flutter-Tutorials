
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
      home: const MyHomePage(title: 'Employees List'),
    );
  }
}
class Person{
  String _name;
  String _email;
  int _age;

  Person(this._name, this._email, this._age);


  String get name{
    return _name;
  }

  String get email{
    return _email;
  }
  @override
  bool operator == (other) => (other is Person) &&(_name==other.name) && (_email == other.email);

}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Person> persons = [
    Person("Ganesh Limbu", "ganesh.limbu@email.com", 24),
    Person("Anish Limbu", 'anish.limbu@email.com', 24),
    Person("Helan Khapung", 'helan.khapung@email.com', 22),
    Person("Nikesh Dangol", "nikesh.dangol@email.con", 23),
    Person("Shishir Khaling", "shishir.khaling@email.com", 23),
    Person("Sagar Majhi", "sagar.majhi@email.com", 24)
  ];
  Person selectedPerson = Person("", "", 0);

  @override
  Widget build(BuildContext context) {
    List<PersonWidget> widgetList = persons.map((person){
      return PersonWidget(context, person, person==selectedPerson, _changeSelectedPerson);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetList
          ),
        ),
      ),
    );
  }

  void _changeSelectedPerson(Person person) {
    setState(() {
      selectedPerson = person;
    });
  }

  void routeToPersonDetailsWidget(BuildContext context, Person person){
    Navigator.push(context,MaterialPageRoute(builder: (context) => PersonDetailsWidget(person)));
  }


}



class PersonWidget extends StatelessWidget{

  const PersonWidget(this.context, this.person, this.isSelected, this._parentSelectionHandler ,{super.key});

  final bool isSelected;
  final Person person;
  final ValueChanged<Person> _parentSelectionHandler;
  final BuildContext context;
  void handleTap(){
    _parentSelectionHandler(person);
  }

  void _navigate(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonDetailsWidget(person)));
  }

  TextStyle listTextStyle(){
    return const TextStyle(fontSize: 16.0,);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: handleTap,
        onDoubleTap: _navigate,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected?Colors.blue:Colors.black12
          ),
          padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
              child: Row(
                children: [
                  Padding(padding:const EdgeInsets.only(left: 20.0),child: SizedBox(height:65, child: Image.asset('assets/profile.png'))),
                  Padding(padding: const EdgeInsets.only(left:20.0,right: 20.0), child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${person.name}", style: listTextStyle(),),
                    Text("Email: ${person.email}", style: listTextStyle(),),
                    Text("Age: ${person._age}", style: listTextStyle(),)
                  ],
                ),
                  ),

              ]
            ),
          
        ),
      ),
    );
  }

}

class PersonDetailsWidget extends StatelessWidget{

  PersonDetailsWidget(this.person, {super.key});

  Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 20.0),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 200,
                  child: Image.asset("assets/profile.png"),
                ),
              ),

              TextFormField(
                initialValue: person.name,
                decoration: const InputDecoration(
                    hintText: 'First Name',
                    labelText: "Full Name",
                    icon: Icon(Icons.person),
                    labelStyle: TextStyle(fontSize: 20.0)
                ),),
              TextFormField(
                initialValue: person.email,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: "Email",
                    icon: Icon(Icons.email),
                    labelStyle: TextStyle(fontSize: 20.0)
                ),),
              TextFormField(
                initialValue: person._age.toString(),
                decoration: const InputDecoration(
                    hintText: 'Age',
                    labelText: "Age",
                    icon: Icon(Icons.panorama_fish_eye_rounded),
                    labelStyle: TextStyle(fontSize: 20.0)
                ),),
            ],
          ),
        ),
      ),
    );
  }

}