
import 'package:flutter/material.dart';
import 'package:myappflutter/globalData/app.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:provider/provider.dart';

class PageConfig extends StatefulWidget{
  @override
  _PageConfig createState() =>_PageConfig();

}
class _PageConfig extends State<PageConfig>{
  HttpService httpService;
  @override
  initState(){
    super.initState();
    httpService=new HttpService();
    BuildContext context= this.context;
    App _app= Provider.of<App>(context,listen: false);
    print("config ${_app.config}");
    if(_app.config==null||(_app.config)?.isEmpty){
      _app.initConfig().then((_config){
        print("@222222 ${_app.config.toString()}");
        pageConfig(_app.config['app_id']);
      });
    }else{
      pageConfig(_app.config['app_id']);
    }
  }
  pageConfig(appid) async{
    var data={
      "page_size":100,
      "query":{
        "store_id":1,
        "app_id":appid
      }
    };
    print("appid-------${appid}");
    return httpService.wxAppConfigGet(data).then((res){
      print("config结果 ${res}");
      print("appid ${appid}");
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
  
}