import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NinjaCard(),
  ));
}


class NinjaCard extends StatefulWidget {
  const NinjaCard({Key? key}) : super(key: key);

  @override
  State<NinjaCard> createState() => _NinjaCardState();
}

class _NinjaCardState extends State<NinjaCard> {

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Ninja ID Card"),
        backgroundColor: Colors.black38,
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            counter += 1;
          });
        },
          child: Icon(
            Icons.add,
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/sanji.png'),
                radius: 40.0,
              ),
            ),
            Divider(height: 40.0,color: Colors.blue,),
            Text("NAME",
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2.0,
                fontSize: 15.0,
              ),),
            SizedBox(height: 10.0,),
            Text("Ganni-vai",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 30.0,),

            Text("CURRENT NINJA LEVEL:",
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2.0,
                fontSize: 15.0,
              ),),
            SizedBox(height: 10.0,),

            Text('$counter',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),),

            SizedBox(height: 30.0,),


            Row(
              children: const [
                Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 10.0,),
                Text("ganni.vai@email.com.np"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





