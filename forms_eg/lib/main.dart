import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        )
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
  bool _checked = false;

  void _onChange(val){
    setState(() {
      _checked =val;
    });
  }

  void _submit(){
    print("Submit button clicked");
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> formWidgetList = [];
    formWidgetList.add(createFNameWidget());
    formWidgetList.add(TextFormField(maxLines: 8,));
    formWidgetList.add(termsCheckbox());
    formWidgetList.add(OutlinedButton(onPressed: _checked?()=>_submit():null, child: const Text("Register")));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(child: Column(
            children: formWidgetList,
          ),),
        ),
      )
    );
  }

  TextFormField createFNameWidget() {
    return TextFormField(
      validator: (value){
        if (value!.isEmpty){
          return "Enter your First Name";
        }
      },
      decoration: const InputDecoration(
        hintText: 'First Name',
        labelText: "Enter your first name",
        icon: Icon(Icons.person)
      ),
      onSaved: (value){},
      autofocus: true,
    );
  }

  Widget termsCheckbox(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(value: _checked, onChanged: (val)=> _onChange(val)),
          const Text("I Agree")
    ]);
  }




}
