import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      new Container(
        child:new ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[ 
            new Container(
              width: 160.0,
              color: Colors.red,
            ),
            new Container(
              width: 160.0,
              color: Colors.blue,
            ),
            new Container(
              width: 160.0,
              color: Colors.green,
            ),
            new Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            new Container(
              width: 160.0,
              color: Colors.orange,
            ),
            
          ],
        )
      ),
      new itemListContainer()
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

class itemListContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    print("width: $width");
    return new Container(
      child: new Wrap(
        children: [
          new Container(
            child: new Column(
              children:[
                Image.network("https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1617008593.29783290.jpg"),
                new Container(
                  child: Text("小米11 Ultra"),
                ),
                new Container(
                  child: Text(
                    "天玑 800U处理器，5000mAh电池，小金刚品质",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                new Container(
                  child: Text(
                    "¥1299",
                    style:TextStyle(
                      color:Colors.red
                    )
                  ),
                ),
              ]
            ),
            width:(width-30)/2,

          ),
          new Container(
            child: new Column(
              children:[
                Image.network("https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1617008593.29783290.jpg"),
                new Container(
                  child: Text("小米11 Ultra"),
                ),
                new Container(
                  child: Text(
                    "天玑 800U处理器，5000mAh电池，小金刚品质",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                new Container(
                  child: Text(
                    "¥1299",
                    style:TextStyle(
                      color:Colors.red
                    )
                  ),
                ),
              ]
            ),
            width:(width-30)/2,
          ),
          
        ],
        spacing:10.0,
        runSpacing :10.0,
        alignment:WrapAlignment.spaceEvenly,
        direction: Axis.vertical,
        verticalDirection:VerticalDirection.down,
        runAlignment : WrapAlignment.start,
        crossAxisAlignment:WrapCrossAlignment.start,
      ),
      width: width,
      color: Colors.yellow,
      alignment:Alignment.topLeft,
    );
  }
}