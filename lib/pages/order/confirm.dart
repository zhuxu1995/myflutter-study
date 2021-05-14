import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/card.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/order/order.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/globalData/sku_provider.dart';

class ConfirmOrder extends StatefulWidget{
  @override
  _ConfirmOrder createState()=> _ConfirmOrder();
}
class _ConfirmOrder extends State<ConfirmOrder>{
  HttpService httpService =new HttpService();
  previewOrderAdd(previewQuery,cb){
    return new FutureBuilder(
      future:  httpService.previewOrder(previewQuery),
      builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot){
        return asyncSnapshot.data; //cb(Map<String, dynamic>.from(asyncSnapshot.data));
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    // print("skus ....${orderSkusPro.skusQuery}");
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;
    var previewOrderQuery={};
    // List sd=[];
    // sd.isNotEmpty
    var buy_para=[];
    if(router_arguments['orderSkuPro'].skusQuery!=null&&router_arguments['orderSkuPro'].skusQuery.isNotEmpty){
      // router_arguments['orderSkuPro'].skusQuery
      if(router_arguments['orderSkuPro'].skusQuery.length>0){
        router_arguments['orderSkuPro'].skusQuery.forEach((v){
          // print("xunhuan ${i}");
          buy_para.add({"sku_id":v.sku_id.toString(),"num":v.sku_num});
          print("xunhuanv ${buy_para[0]['sku_id'].runtimeType}");
        });
      }
      
    }
    print("provider ${router_arguments['orderSkuPro'].skusQuery.runtimeType}");
    previewOrderQuery["buy_para"]={
      "buy_para":buy_para
    };
    // previewOrderQuery["buy_para"]['buy_para']=buy_para;
    previewOrderQuery["address_id"]=-1;
    // previewOrderQuery["note"]="";
    return Scaffold(
      appBar: AppBar(),
      body: previewOrderAdd(previewOrderQuery,(result){
        // print("previeweOrder ${result}");
        // var previewOrder=order.fromJson(result);
        // print("预览订单 ${previewOrder.items.length}");
        return Text("222222");
        return Column(
          children: [
            // if(previewOrder.items.isNotEmpty&&previewOrder.items.length>0){
              Container(
                height:(360),
                child:Text("222222222"),
                // new ListView(
                //   children: <Widget>[
                //     if(previewOrder!=null&&previewOrder.items.length>0)
                //       // for(var item in previewOrder.items)
                //       //   NCard(
                //       //   title: item.title,
                //       //   desc: item.skuProperties,
                //       //   num: item.quantity,
                //       //   price: item.payment,
                //       //   image: Image.network(item.image))
                //       Text("222222222"),
                //   ],
                // )
              )   
             
            // }
          ],
        );
      }),
    );
  }
  
}