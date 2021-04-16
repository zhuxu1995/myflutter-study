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
class TutorialHome extends State {
    int _selectedIndex = 0;
    int _counter =0;
    @visibleForTesting
    void increments(){
      setState(() {
        _counter++;
      });
    }
    static const TextStyle optionStyle = TextStyle(fontSize:30,fontWeight:FontWeight.bold);
    //  CupertinoButton button1= CupertinoButton(
    //   onPressed:increments,
    //   child: new Text('Increment'),
    //   );
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
  List<String> image =<String>[
    'images/001.jpg',
    'images/002.jpg',
    'images/003.jpg',
    'images/004.jpg',
  ];
  int currentIndex = 1;
  void setindex( int val){
    print("$val");
    setState(() {
      if(val+1>=image.length){
        currentIndex=0;
      }else if(val+1<image.length&&val-1>=0){
        currentIndex = val;
      }else if(val-1<0){
        currentIndex =image.length-1;
      } 
    });
  }
  @override
  Widget build(BuildContext context){
    return GestureDetector( 
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child:GestureDetector(
                  child:Image.asset(image[(currentIndex==0)?image.length-1:currentIndex-1]),
                  onTap: (){
                    setindex(currentIndex-1);
                  },
                )
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(image[currentIndex],),
            ),
            Expanded(
              child: GestureDetector(
                child: Image.asset(image[(currentIndex+1>=image.length)?0:currentIndex+1]),
                onTap: (){
                    print(this);
                    setindex(currentIndex+1) ;
                },
              ),
            ),
          ],
        )
      ),
      onTap: (){
      },    
    );
  }
}
class Hometow extends StatefulWidget{
  @override 
  HomeStatetow createState() => new HomeStatetow();
}
class HomeStatetow extends State<Hometow>{
  List<String> image =<String>[
    'images/001.jpg',
    'images/002.jpg',
    'images/003.jpg',
    // 'images/004.jpg',
  ];
  List<Image> newImage(List<String> images){
    List <Image> imageList = <Image>[];
    print(images);
    images.forEach((val){
      print('img $val');
      imageList.add(Image.asset(val,width:100));
    });
    return imageList;
  }
  @override
  Widget build(BuildContext context){
    return GestureDetector( 
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: newImage(image),
        )
      ),
      onTap: (){
      },    
    );
  }
}
