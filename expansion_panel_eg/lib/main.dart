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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  List<ExpansionListData> expansionDataList = [
    ExpansionListData(
        "Can I backup my data?",
        "dsfuysdiu fudsy fiusdyf "
            "usdyf iudsyf udsyfiuysd ufyuisdyfi sduiyfiusdyf dsyui u", false),
    ExpansionListData(
        "How can I increase my space?",
        "sydufy "
            "dsuiyfuidysu fusyufsdyuif ysudiy fuydsufy suyf udsy fu", false),
    ExpansionListData(
        "How do I cancel?",
        "ddsufysd yfds fsduyf sdyf "
            "sudyuy fsudyf sydyf dsy fdsuyf udsufy udsyfdsfyuysdf uyud", false),
    ExpansionListData(
        "How do I change language?",
        "udsuf sdifuu fdsuif "
            "uf dsufdisu fius wewqw qeqweqwyiquuiqweqwewqe weewe wewe", false),
    ExpansionListData(
        "How do I search?",
        "ooioio ioi oio i odsfudsifsdf"
            " dfdsfdsui idufu dsiuf isduf iduf idsu fisduf iusidf ", false),
    ExpansionListData(
        "How do I view on other devices?",
        "idusdf isu "
            "idsu idsu fisduf usyfuedy ewuyduyed uyeu dyeudy uweyu", false),
    ExpansionListData(
        "How do I view my history",
        "iirewy syfudy fu "
            "yfsduyfds yfdsuyf udsfydsufy sduyf dsuyf udsyf udsyuee", false),
    ExpansionListData(
        "Is my subscription cost going to go up?",
        "wieureiy dys udsyyf "
            "dsufy dusyfudsy fuysdu udsyuyfudsyfuewyrwreooioou uiy", false),
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState(expansionDataList);
}

class ExpansionListData{
  String _title;
  String _body;
  bool _expanded;

  ExpansionListData(this._title, this._body, this._expanded);

  @override
  String toString() {
    return "ExpansionListData(_title, _body, _expanded){_title: $_title, _body: $_body, _expanded: $_expanded}";
  }

  String get title{
    return _title;
  }
  String get body{
    return _body;
  }

  bool get expanded{
    return _expanded;
  }

  set expanded(bool value){
    _expanded = value;
  }

}

class _MyHomePageState extends State<MyHomePage> {
  List<ExpansionListData> expandData;

  _MyHomePageState(this.expandData);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  _onExpansion(int panelIndex, bool isExpanded) {
// Toggle the expanded state. Using setState will force 'build' to fire.
    setState(() {
      expandData[panelIndex].expanded = !(expandData[panelIndex].expanded);
    });
  }

  _showSnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar( content: Text('An unexpected error occurred: Error!'),));
  }
  @override
  Widget build(BuildContext context) {

    List<ExpansionPanel> expansionPanelList = [];
    for(int i=0, ii=expandData.length;i<ii;i++) {
      var expansionPanelData = expandData[i];
      expansionPanelList.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(expansionPanelData.title,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)));
        }, body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(expansionPanelData.body,
              style:
              const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic))),
        isExpanded: expansionPanelData.expanded
      ));

    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
      ),
      body: SingleChildScrollView(child: ExpansionPanelList(children: expansionPanelList,expansionCallback: _onExpansion,),),
      floatingActionButton: FloatingActionButton(onPressed: _showSnackBar,child: const Text("Error"),),
    );
  }
}
