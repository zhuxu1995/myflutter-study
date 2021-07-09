import 'package:flutter/material.dart';
import 'package:myappflutter/globalData/member.dart';
import 'package:myappflutter/helper/pageConfig.dart';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:provider/provider.dart';

class StaticNavigatorPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Provider.of<TokenStatus>(context,listen:false).setTokenGuoQi(false);
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("静态路由页"),
      //   leading: new IconButton(
      //       icon: new Icon(Icons.arrow_back_ios),
      //       tooltip: 'Navigation menu',
      //       onPressed: (){
      //             Navigator.of(context).pop();
      //       },
      //   ),
      //   actions: <Widget>[
      //       new IconButton(
      //         icon: new Icon(Icons.home),
      //         tooltip: '首页',
      //         onPressed: (){
      //             Navigator.of(context).pop();
      //         },
      //       ),
      //   ],
      // ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          
        },
        child: new Text("返回"),
      ),
      body: new Center(
        child: Home1(),
      ),
    );
  }
}
class Home1 extends StatefulWidget{
  @override
  _Home1 createState() =>_Home1();
  
}
class _Home1 extends State<Home1>{
  DhflocalStore dhflocalStore ;
  dynamic token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return new PageConfig();
  }
  
}