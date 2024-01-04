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
      theme: ThemeData(primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BBC News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class News{
  late DateTime _dt;
  late String title;
  late String text;

  News(this._dt, this.title, this.text);
}

class NewsCard extends StatefulWidget{
  final News _news;
  const NewsCard(this._news, {super.key});


  @override
  State<NewsCard> createState() => _NewsCardState(_news);

}

class _NewsCardState extends State<NewsCard>{
    late final News _news;
    _NewsCardState(this._news);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        child: Padding(
        padding: const EdgeInsets.all(20.0), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(image: NetworkImage("https://www.bbc.co" ".uk/news/special/2015/newsspec_10857/bbc_news_logo.png?cb=1")),
            Padding(padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text("${_news._dt.month}//${_news._dt.day}/${_news._dt.year}", style: const TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),),),
            Padding(padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(_news.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),),
            Text(_news.text, style: const TextStyle(fontSize: 14.0), overflow: TextOverflow.fade,),
            Row(children: [
              TextButton(child: const Text("Share"), onPressed: () => {}),
              TextButton(child: const Text("Bookmark"), onPressed: () => {}),
              TextButton(child: const Text("Link"), onPressed: () => {})
            ],)

        
    ],
    ),
      )
    ));
  }

}
class _MyHomePageState extends State<MyHomePage> {
  final List<News> _newsList = [
  News(DateTime(2018, 12, 1),
      "Mass shooting in Atlanta",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet " +
          "tortor pretium, interdum magna sed, pulvinar ligula."), News(
        DateTime(2019, 1, 12),
        "Carnival clown found drunk in Misisippi",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet " +
            "tortor pretium, interdum magna sed, pulvinar ligula."), News(
        DateTime(2019, 2, 12),
        "Walrus found in family pool in Florida",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet " +
            "tortor pretium, interdum magna sed, pulvinar ligula."), ];

  @override
  Widget build(BuildContext context) {
    List<NewsCard> newsCardList = _newsList.map((news)=>NewsCard(news)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: newsCardList
        ),
      ),

    );
  }
}
