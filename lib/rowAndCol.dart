import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    home: new MyApp(),
  ));
}
class MyApp extends StatefulWidget {

  @override
  TutorialHome createState() => new TutorialHome();
}
class TutorialHome extends State<MyApp> {
    int _selectedIndex = 0;
    @visibleForTesting
    
    static const TextStyle optionStyle = TextStyle(fontSize:30,fontWeight:FontWeight.bold);
     List<Widget> _widgetOptions = <Widget>[
      new Home(),
      Text('Index 1:User2',
        style: optionStyle
      )
    ];
    void _onTapSelected(int index){
      setState((){
          _selectedIndex = index;
      });
    }
    var that=TutorialHome;
    @override
    Widget build(BuildContext context) {
      //Scaffold是Material中主要的布局组件.
      return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null,
          ),
          title: new Text('Example title'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        //body占屏幕的大部分
        body: new Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'Add', // used by assistive technologies
          child: new Icon(Icons.add),
          onPressed: null,
        ),
        
        bottomNavigationBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "我的1")
          ],
          currentIndex: _selectedIndex,
          activeColor : Colors.amber[800],
          onTap: _onTapSelected,
        ),
      );
    }
          
}

class Home extends StatefulWidget{
  @override 
  HomeState createState() => new HomeState();
}
class HomeState extends State<Home>{
   final row= Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
   );
  final ratings = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new Row2().row,
        Text(
          '170 Reviews',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context){
    return GestureDetector( 
     child:ratings,
    );
  }
}

class _CounterState extends State<Counter> {
  int _counter =0;
  void _increment(){
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('Increment'),
        ),
        new Text('Count: $_counter'),
      ],
    );
  }

}

class Counter extends StatefulWidget {
   @override
  _CounterState createState() => new _CounterState();
}
class RowCounter extends StatefulWidget {
   @override
   Row1 createState() => new Row1();
}
class Row1 extends State<RowCounter> {
  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
  }
}
class Row2 extends Row{
      // TODO: implement build
       var row= Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );
}