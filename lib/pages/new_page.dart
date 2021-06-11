import 'package:flutter/material.dart';
import 'package:myappflutter/globalData/member.dart';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:provider/provider.dart';
DhflocalStore dhflocalStore =new DhflocalStore();
class StaticNavigatorPage extends StatelessWidget {
  dynamic token =   dhflocalStore.getToken();

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
          print("22222222222 $token");
          token.then((val){
            print("111111$val");
          });
        },
        child: new Text("返回"),
      ),
      body: new Center(
        child: Text("静态路由可以传入一个routes参数来定义路由。但是这里定义的路由是静态的，"
            "它不可以向下一个页面传递参数，利用push到一个新页面,pushNamed方法是有一个Future的返回值的"
            "，所以静态路由也是可以接收下一个页面的返回值的。但是不能向下一个页面传递参数"),
      ),
    );
  }
}