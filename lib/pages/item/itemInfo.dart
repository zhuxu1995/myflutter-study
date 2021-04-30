import 'package:flutter/material.dart';
import 'package:myappflutter/httpServices/httpService.dart';

class ItemInfo extends StatefulWidget{
  @override
  _ItemInfo createState()=> _ItemInfo();
}
class _ItemInfo extends State<ItemInfo>{
  HttpService httpService =new HttpService();
  @override
  getItem(itemId) async{
    return httpService.itemPackOne(itemId).then((res){
        return res;
    });
  }
  getItemDetail(itemId,cb){
    return new FutureBuilder(
      future: getItem(itemId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot){
        print("asyncSnapshot222222222 ${asyncSnapshot}");
        return cb();
      }
    );
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;
    print("router_arguments ${router_arguments}");
    var item_id;
        return Scaffold(
          appBar: AppBar(
          ),
          body:getItemDetail(router_arguments['item_id'],(){
            return Container(
              child:Column(
                children: [
                  
                ],
              )
            );
          })
    );
  }
}