import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text('First App 1'),
        centerTitle: true,
      ),
      // body: Center(
      //   // child: Text('Welcome User',
      //   //   style: TextStyle(
      //   //     color: Colors.grey[600],
      //   //     fontSize: 20.0,
      //   //     fontWeight:  FontWeight.bold,
      //   //     letterSpacing: 2.0,
      //   //     fontFamily: 'IndieFlower',
      //   //
      //   //   ),),
      //   // child: Image.asset("assets/eg.jpg"),
      //   // child: Icon(
      //   //   Icons.airport_shuttle,
      //   //   color: Colors.lightBlue,
      //   //   size: 50.0,
      //   // ),
      //
      //   // child: TextButton(
      //   //   onPressed: (){},
      //   //    child: Text('Click me') ,
      //   //
      //   // ),
      //
      //   child: IconButton(
      //     onPressed: (){},
      //     icon: Icon(
      //       Icons.alternate_email
      //     ),
      //     color: Colors.blueAccent,
      //
      //
      //   ),
      //
      // ),
      // body: Container(
      //   // padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      //   padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
      //   margin: EdgeInsets.all(10),
      //   color: Colors.grey[400],
      //   child: Text("Hello"),
      // body: Padding(
      //   padding: EdgeInsets.all(90.0),
      //   child: Text('Hello'),
      // ),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text("Hello World"),
      //     TextButton(onPressed: (){}, child: Text("Click me")),
      //     Text("Bye"),
      //   ],
      // ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: TextButton(onPressed: (){}, child: Text("Click")),
      //     ),
      //     Text("HEllo"),
      //     Container(
      //       child: Text("Bye Bye"),
      //     )
      //   ],
      // ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.cyan,
              child: Text("1")
            ),

          ),
          Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.pink,
              child: Text("2")
          ),
          Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber,
              child: Text("3")
          ),
          Expanded(child: Image.asset("assets/eg.jpg"),flex: 3,)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Clicked");
        },

        child: Text('Click'),

        backgroundColor: Colors.red[600],
      ),
    );

  }
}
