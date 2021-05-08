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
      new Counter(),
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

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text("Count: $count");
  }
  
}
class CounterIncrmentor extends StatelessWidget {
  CounterIncrmentor({this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context){
    return new RaisedButton(onPressed: onPressed,
    child:new Text("increment"),
    );
  }
}
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}
class _CounterState extends State<Counter> {
  int _counter  = 0;
  void _increment(){
    setState(() {
      ++_counter;
      print("_CounterState $_counter");
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrmentor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}