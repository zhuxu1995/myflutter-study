import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/card.dart';
// import 'package:myappflutter/component/addressListShow.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/order/order.dart';
import 'package:myappflutter/model/address/address.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/globalData/sku_provider.dart';

class ConfirmOrder extends StatefulWidget{
  @override
  _ConfirmOrder createState()=> _ConfirmOrder();
}
class _ConfirmOrder extends State<ConfirmOrder>{
  HttpService httpService =new HttpService();
  previewOrderAdd(previewQuery){
    return new FutureBuilder(
      future: httpService.addressGet({}),
      builder:  (BuildContext context, AsyncSnapshot<dynamic> address_asyncSnapshot){
          print("data ${address_asyncSnapshot.data}");
          if(address_asyncSnapshot.data!=null&&address_asyncSnapshot.data.isNotEmpty){
            var address_list =address.fromJson(Map<String, dynamic>.from(address_asyncSnapshot.data));
            var addressObj=null;
            if(address_list!=null&&address_list.total_count>0){
              addressObj=address_list.deliver_addrs[0];
              print("address type ${addressObj.real_name}");
              previewQuery["address_id"]=address_list.deliver_addrs[0].address_id;
            }
            return new FutureBuilder(
              future:  httpService.previewOrder(previewQuery),
              builder: (BuildContext context1, AsyncSnapshot<dynamic> asyncSnapshot){
                if(asyncSnapshot.hasData&&asyncSnapshot.data!=null){
                  var orderJson=Map<String,dynamic>.from(asyncSnapshot.data) ;
                  var previewOrder=order.fromJson(orderJson);
                  return Column(
                    children: [
                      
                      if(previewOrder!=null&&previewOrder.items!=null&&previewOrder.items.isNotEmpty&&previewOrder.items.length>0)
                        Container(
                          height:(360),
                          child:
                          new ListView(
                            children: <Widget>[
                              if(addressObj!=null)
                                // Container(
                                //   height:100,
                                //   child:
                                //   new AddressListShow(
                                //     list:[
                                //       AddressInfo(
                                //       name: addressObj.real_name,
                                //       tel: addressObj.phone,
                                //       province: addressObj.province,
                                //       city: addressObj.city,
                                //       county: addressObj.district,
                                //       addressDetail: addressObj.address,
                                //       isDefault: false),
                                //     ]
                                //   )
                                // ),
                              
                              if(previewOrder!=null&&previewOrder.items.length>0)
                                for(var item in previewOrder.items)
                                  NCard(
                                  title: item.title,
                                  desc: item.skuProperties,
                                  num: item.quantity,
                                  price: item.payment,
                                  image: Image.network(item.image))
                            ],
                          )
                        )   
                    ],
                  );
                }else{
                  return new Container(child:Text("出错，请后退重试"));
                }
                
              }
          
            );
          }else{
            return new Container(child:Text("出错，请后退重试"));
          }
          
      },
    ) ;
  
  }
  @override
  Widget build(BuildContext context) {
    // print("skus ....${orderSkusPro.skusQuery}");
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;
    var previewOrderQuery={};
    print("${router_arguments}");
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
    // print("provider ${router_arguments['orderSkuPro'].skusQuery.runtimeType}");
    previewOrderQuery["buy_para"]={
      "buy_para":buy_para
    };
    // previewOrderQuery["buy_para"]['buy_para']=buy_para;
    previewOrderQuery["address_id"]=-1;
    // previewOrderQuery["note"]="";
    return Scaffold(
      appBar: AppBar(),
      body:Container(
        child:  previewOrderAdd(previewOrderQuery)
        // new FutureBuilder(
        //   future: httpService.addressGet({}),
        //   builder:  (BuildContext context, AsyncSnapshot address_asyncSnapshot){
        //         print("data22222 ${address_asyncSnapshot.data}");
        //         if(address_asyncSnapshot.data!=null&&address_asyncSnapshot.data.isNotEmpty){
        //           var address_result=Map<String, dynamic>.from(address_asyncSnapshot.data);
        //           if(address_result!=null&&address_result.isNotEmpty){
        //             var address_list =address.fromJson(address_result);
        //             print("address ${address_list.deliverAddrs[0].toJson()}");
        //             if(address_list!=null&&address_list.totalCount>0){
        //               previewOrderQuery["address_id"]=address_list.deliverAddrs[0].addressId;
        //             }
        //             return new Container(child: Text("333333"),);
        //           }
        //         }else{
        //           return new Container();
        //         }
        //     },
        // ) ,
      ),
    );
  }
  
}
