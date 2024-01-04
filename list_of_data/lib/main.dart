import 'package:flutter/material.dart';
import 'package:list_of_data/quote_card.dart';
import 'quote.dart';

void main() {
  runApp(const MaterialApp(
    home:Home(),
  ));
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Quote> quotes = [
    Quote(text: "Be yourself; Everyone else is already taken", author: "Osca Wilde"),
    Quote(text: "I have nothing to declare except my genius", author: "Oscar Wilde"),
    Quote(text: "The truth is rarely pure and never simple", author: "Oscar Wilde")
  ];

  List<Map<String,String>> quotesList = [{"Be yourself":"Ganesh"},
    {"I have nothing to declare except my genius":"Ganni"},
    {"The truth is rarely pure and never simple":"Gn"}];

  // Widget quoteTemplate(quote){
  //   return QuoteCard(quote: quote);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Text("List of Data"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // children: quotes.map((e) => Text('${e.author} : ${e.text}')).toList(),
        children: quotes.map((e) => QuoteCard(quote: e,delete: (){
          setState(() {
            quotes.remove(e);
          });
        },)).toList(),
      ),
    );
  }
}

