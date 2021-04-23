import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myappflutter/component/footerTabBar.dart';
import 'package:myappflutter/model/member.dart';
import 'package:myappflutter/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  Map<String, WidgetBuilder> routes = new Map<String, WidgetBuilder>();
  MyRoutes.routes_list.forEach((val) => routes.addAll(val['route']));
  print("route $routes");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: new MemberModel()),
      ],
      child: new MaterialApp(
        title: 'Flutter Tutorial',
        home: new MyApp(),
        routes:routes,
        onGenerateRoute: (RouteSettings routeSettings){
          print("ddd $routeSettings");
        },
      )
    )
  );
}
class MyApp extends StatefulWidget {

  @override
  TutorialHome createState() => new TutorialHome();
}
class TutorialHome extends State<MyApp> {
    int _selectedIndex = 0;
    @visibleForTesting
    
    @override
    Widget build(BuildContext context) {
      //Scaffold是Material中主要的布局组件.
      return new footTabBar();
    }
          
}
//xiamain无关代码
//
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
                  child: Text("小米11 Ultra",textAlign: TextAlign.left,),
                  width: (width-30)/2,
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
                  child: Text("小米11 Ultra",textAlign: TextAlign.left,),
                  width: (width-30)/2,
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
      alignment:Alignment.center,
    );
  }
}