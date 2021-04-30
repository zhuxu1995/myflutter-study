import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myappflutter/pages/catitems.dart';
import 'package:myappflutter/pages/new_page.dart';
import 'package:myappflutter/pages/login.dart';
import 'package:myappflutter/pages/my_member.dart';
class footTabBar extends StatefulWidget {

  @override
  footTabBarNew createState() => new footTabBarNew();
}
class footTabBarNew extends State<footTabBar>{
  String title = "首页";
  int _selectedIndex=0;
  Widget body =new StaticNavigatorPage();
  List<BottomNavigationBarItem> items= [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.border_all),label: "分类"),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: "我的")
  ];
  void _onTapSelected(int index){
      setState((){
          _selectedIndex = index;
          if (index==0){
            title = "首页";
            body = new StaticNavigatorPage();
          }else if(index==1){
            title = "分类";
            body = new Container(child:new SideCatViewMenu());
          } else if(index==2) {
            title = "我的";
            body =new MyMember();
          }
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          title
        ),
        
      ),
      body: body,
      bottomNavigationBar: CupertinoTabBar(
          items: items,
          currentIndex: _selectedIndex,
          activeColor : Colors.amber[800],
          onTap: _onTapSelected,
      )
    );
  }
}