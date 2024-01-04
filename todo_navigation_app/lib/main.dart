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
      home:  MyHomePage(),
    );
  }
}

class Todo{
  String title;
  String description;

  Todo(this.title, this.description);
}

class MyHomePage extends StatelessWidget{

  final List<Todo> todoList = [
    Todo("Item 1", "First to-do of the list"),
    Todo("Item 2", "Second to-do of the list"),
    Todo("Item 3", "Third to-do of the list"),
  ];

  MyHomePage({super.key});

  void _itemPressed(BuildContext context, index){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoPage(todoList[index])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: ListView.builder(

          itemBuilder: (context, index){
            return ListTile(
              title: Text(todoList[index].title),
              onTap: ()=>_itemPressed(context, index),
            );
          }),
    );
  }

}


class InfoPage extends StatelessWidget{

  const InfoPage(this.todo, {super.key});

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Text(todo.description, style: const TextStyle(fontSize: 30),),
      ),
    );
  }

}
