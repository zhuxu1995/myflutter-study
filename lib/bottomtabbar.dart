import 'package:flutter/material.dart';

// void main() {
//   runApp(new MaterialApp(
//     title: 'Flutter Tutorial',
//     home: new Counter(),
//   ));
// }

  
class Counter extends StatefulWidget {

  @override
  TutorialHome createState() => new TutorialHome();
}
class TutorialHome extends State {
    int _selectedIndex = 0;
    static const TextStyle optionStyle = TextStyle(fontSize:30,fontWeight:FontWeight.bold);
    static const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home2',
        style: optionStyle,
      ),
      Text('Index 1:User2',
        style: optionStyle
      )
    ];
    void _onTapSelected(int index){
      setState((){
          _selectedIndex = index;
      });
    }
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
              icon: new Icon(Icons.home),
              tooltip: 'Home',
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "我的")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onTapSelected,
        ),
      );
    }
          
}