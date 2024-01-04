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
      home: HomeWidget1(),
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
  int _counter = 0;

  BoxFit _boxFit = BoxFit.cover;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showBoxFitDialog() async{
    BoxFit? boxFit = await showDialog<BoxFit>(context: context, builder: (BuildContext buildcontext){
      return SimpleDialog(title: Text("Select Box Fit"), children: [
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.cover); },
          child: const Text('Cover'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.contain); },
          child: const Text('Contain'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.fill); },
          child: const Text('Fill'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.fitHeight); },
          child: const Text('Fit Height'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.fitWidth); },
          child: const Text('Fit Width'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.scaleDown);
        },
          child: const Text('Scale Down'), ),
        SimpleDialogOption( onPressed: () {
          Navigator.pop(context, BoxFit.none); },
          child: const Text('None'), ),
      ], );
    });
    if (boxFit != null) {
      // not cancelled
      setState(() {
        _boxFit = boxFit;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> kittenTiles = [];
    for (int i = 1; i < 14; i ++) {
      String imageUrl = "assets/$i.png";
      kittenTiles.add(GridTile(child: Image.asset(imageUrl, fit: _boxFit))); }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OrientationBuilder(builder: (context, orientation) { return GridView.count(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3, childAspectRatio: 1.0,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: kittenTiles); }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBoxFitDialog,
        child: const Icon(Icons.select_all),
      ),
    );
  }
}

class GridOptions{

  GridOptions(this._crossAxisCountPortrait, this._crossAxisCountLandscape, this._childAspectRatio, this._padding, this._spacing);
  late int _crossAxisCountPortrait;
  late int _crossAxisCountLandscape;
  late double _childAspectRatio;
  late double _padding;
  late double _spacing;

  GridOptions.copyOf(GridOptions gridOptions) { this._crossAxisCountPortrait = gridOptions._crossAxisCountPortrait; this._crossAxisCountLandscape = gridOptions._crossAxisCountLandscape; this._childAspectRatio = gridOptions._childAspectRatio;
  this._padding = gridOptions._padding;
  this._spacing = gridOptions._spacing;
  }
  @override
  String toString() {
    return 'GridOptions{_crossAxisCountPortrait: $_crossAxisCountPortrait, _crossAxisCountLandscape: $_crossAxisCountLandscape, _childAspectRatio: $_childAspectRatio, _padding: $_padding, _spacing: $_spacing}';
  }
}
class CustomDialog extends StatefulWidget {
  final GridOptions _gridOptions;
  const CustomDialog(this._gridOptions, {super.key});

  


  @override
  State<CustomDialog> createState() => _CustomDialogState(GridOptions.copyOf(_gridOptions));
}

class _CustomDialogState extends State<CustomDialog> {

  GridOptions _gridOptions;
  _CustomDialogState(this._gridOptions);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 400,
      width: 250,
      child: Column(
        children: [
          const Text("Grid Options", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          Row(children: [
            Spacer(),
            const Text("Cross AxisCount Portrait"),
            Spacer(),
            DropdownButton<int>(value: _gridOptions._crossAxisCountPortrait, items: <int>[2, 3, 4, 5, 6].map((int e){ return DropdownMenuItem(value: e, child: new Text(e.toString()),);}).toList(),
              onChanged: (newValue){setState(() {
              _gridOptions._crossAxisCountPortrait = newValue!;
            });}),
          ],),
          Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Spacer(),
          const Text("Cross Axis Count Landscape"),
          const Spacer(),
          DropdownButton<int>(
            value: _gridOptions._crossAxisCountLandscape, items: <int>[2, 3, 4, 5, 6].map((int value) {
            return DropdownMenuItem<int>( value: value,
              child: Text(value.toString()),
            );
          }).toList(),
            onChanged: (newValue) {
              setState(() {
                _gridOptions._crossAxisCountLandscape = newValue!;
              });
            }, ),
          const Spacer(), ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Spacer(),
          const Text("Aspect Ratio"),
          Spacer(),
           DropdownButton<double>(
            value: _gridOptions._childAspectRatio,
            items: <double>[0.5, 0.75, 1.0, 1.5, 2.0, 2.5].map((double value) {
              return DropdownMenuItem<double>( value: value,
                child:  Text(value.toString()),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _gridOptions._childAspectRatio = newValue!;
              }); },
          ),
          const Spacer(), ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Spacer(),
          const Text("Padding"),
          const Spacer(),
          DropdownButton<double>( value: _gridOptions._padding, items:
          <double>[1.0, 2.0, 4.0, 8.0, 16.0, 32.0].map((double value) { return DropdownMenuItem<double>(
            value: value,
            child: Text(value.toString()), );

          }).toList(),
            onChanged: (newValue) {
              setState(() {
                _gridOptions._padding = newValue!;
              }); },
          ),
          const Spacer(), ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Spacer(),
          const Text("Spacing"),
          const Spacer(),
          DropdownButton<double>( value: _gridOptions._spacing, items:
          <double>[1.0, 2.0, 4.0, 8.0, 16.0, 32.0].map((double value) { return DropdownMenuItem<double>(
            value: value,
            child: Text(value.toString()), );
          }).toList(),
            onChanged: (newValue) {
              setState(() {
                _gridOptions._spacing = newValue!;
              }); },
          ),
          const Spacer(), ]),
        TextButton(
            child: const Text("Apply"),
            onPressed: () => Navigator.pop(context, _gridOptions))
        ])); }

}

class HomeWidget1 extends StatefulWidget {
  HomeWidget1() : super();
@override
_HomeWidgetState createState() => new _HomeWidgetState(); }
class _HomeWidgetState extends State<HomeWidget1> {
  List<Widget> _kittenTiles = [];
  GridOptions _gridOptions = GridOptions(2, 3, 1.0, 4.0, 4.0);
  _HomeWidgetState() : super() {
  for (int i = 1; i < 14; i += 1) {
    String imageUrl = "assets/$i.png"; _kittenTiles.add(GridTile(
        header: const GridTileBar(
          title: Text("Cats", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        ),
        footer: const GridTileBar(
            title: Text("How cute",
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold))),
        child: Image.asset(imageUrl, fit: BoxFit.cover))); }
}
void _showGridOptionsDialog() async {
  GridOptions? gridOptions = await showDialog<GridOptions>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(child: CustomDialog(_gridOptions)); });
  if (gridOptions != null) { setState(() {
    _gridOptions = gridOptions; });
  } }
@override
Widget build(BuildContext context) {
  return Scaffold( appBar: AppBar(
      title: const Text("GridView"), ),
  body: OrientationBuilder(builder: (context, orientation) { return GridView.count(
  crossAxisCount: (orientation == Orientation.portrait) ? _gridOptions._crossAxisCountPortrait
      : _gridOptions._crossAxisCountLandscape,
  childAspectRatio: _gridOptions._childAspectRatio, padding: EdgeInsets.all(_gridOptions._padding), mainAxisSpacing: _gridOptions._spacing, crossAxisSpacing: _gridOptions._spacing, children: _kittenTiles);
  }),
  bottomNavigationBar: Container(
  child: Text(_gridOptions.toString()), padding: const EdgeInsets.all(20.0)), floatingActionButton: FloatingActionButton(
  onPressed: _showGridOptionsDialog, tooltip: 'Try more grid options', child: const Icon(Icons.refresh),
  ), // This trailing comma makes auto-formatting nicer for build methods.
  );
} }

