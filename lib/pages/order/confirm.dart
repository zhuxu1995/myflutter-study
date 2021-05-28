import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/card.dart';
import 'package:flutter_vant_kit/widgets/field.dart';
import 'package:flutter_vant_kit/widgets/numberKeyboard.dart';
import 'package:flutter_vant_kit/widgets/submitBar.dart';
import 'package:myappflutter/component/addressShow.dart';
import 'package:myappflutter/globalData/form_provider.dart';
// import 'package:myappflutter/component/addressListShow.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/order/order.dart';
import 'package:myappflutter/model/address/address.dart';
import 'package:myappflutter/model/skuItem/goods_details_model.dart';
import 'package:myappflutter/model/udform/formconfig.dart';
import 'package:myappflutter/packages/weui/notify/index.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/globalData/sku_provider.dart';


class ConfirmOrder extends StatefulWidget{
  @override
  _ConfirmOrder createState()=> _ConfirmOrder();
}
class _ConfirmOrder extends State<ConfirmOrder>{
  HttpService httpService =new HttpService();
  OrderSkuProvider orderSkuPro;
  var  item_order_type ;
  bool isNumberInputShow=false;
  FormDataAdd(provider,previewOrder,cb){
    var titles=<dynamic>[],options=<dynamic>[];
    if(provider.form_options.length>0){
      provider.form_options.forEach((form_data) {
        if(form_data.type == "text" ||
        form_data.type == "number" ||
        form_data.type == "idcard" ||
        form_data.type == "digit" ||
        form_data.type == "textarea" ||
        form_data.type == "mobile"){
          options.add(form_data.options);
          titles.add(form_data.type_id);
        }else if(form_data.type == "date"){
          // options.add(
          //   form_data.date+" "+
          //   form_data.time)
          // titles.add(form_data.type_id);
        }else if(form_data.type == "riqi"){
          options.add(form_data.options);
          titles.add(form_data.type_id);
        }
      });
      var store_id= previewOrder.storeId;
      var form_fujia = {
          "store_id": store_id,
          "options": options,
          "title": titles,
          "order_id": previewOrder.orderId,
      };
      form_fujia["type"] = "order" + (item_order_type > 0 ? item_order_type.toString() : '');
      print("data ${form_fujia.toString()}");
      httpService.formDataAdd(form_fujia).then((res){
        if(res["Msg"]!='ok'){
            WeNotify.error(context)(
              child: Text(res['Msg'])
            );
        }else{
          cb(res);
          
        }
      });
    }else{
      cb(null);
    }
    
  }
  FieldForm(form,provider,context){
    TextEditingController testInput = TextEditingController();
    return Field(
      key:ValueKey(form.type_id),
      placeholder: "请输入"+form.title,
      label:form.title,
      controller:  testInput,
      readonly:(form.type=='mobile')?true:false,
      onClick: () {
            if(isNumberInputShow){
              print("关闭数字键盘");
              isNumberInputShow=false;
              Navigator.pop(context);
            }
            if(form.type=="mobile"){
              // setState(() {
              isNumberInputShow=true;
              // });
              NumberKeyboard(
              value: testInput.text,
              maxlength: 11,
              closeButtomText: "完成",
              extraKey: ".",
              onChange: (String val) {
                // setState(() {
                //   testInput.text = val;
                // });
              }).show(context);
            }
            
            
      },
      onSubmitted: (val) {
        // Utils.toast("submitted: $val");
        print("输入内容 ${form.title+val}");
        print("formData ${provider.form_options.toString()}");
        provider.form_options.forEach((element) { 
          print("title ${element.title}");
          if(element.type_id==form.type_id){
            element.options=val;
          }
        });
      },
    );
  }
  var address_id;
  previewOrderAdd(previewQuery,pageContext) {
    var addressQuery={};
    if(address_id!=null){
      addressQuery["query"]={
        "address_id":address_id
      };
    }
    return new FutureBuilder(
      future: httpService.addressGet(addressQuery),
      // ignore: await_only_futures
      builder:  (BuildContext context, AsyncSnapshot<dynamic> address_asyncSnapshot) {
          final height = MediaQuery.of(context).size.height;
          print("data ${address_asyncSnapshot.data}");
          if(address_asyncSnapshot.data!=null&&address_asyncSnapshot.data.isNotEmpty){
            var address_list ;
            try{
              address_list=address.fromJson(Map<String, dynamic>.from(address_asyncSnapshot.data));
            }catch(e){
              print("解析adresss ${e}");
            }
            var addressObj=null;
            if(address_list!=null&&address_list.total_count>0){
              addressObj=address_list.deliver_addrs[0];
              print("address type ${addressObj.real_name}");
              previewQuery["address_id"]=address_list.deliver_addrs[0].address_id;
            }
            print("previewQuery${previewQuery.toString()}");
            print("previewQuery${previewQuery['buy_para'].runtimeType}");
            return new FutureBuilder(
              future:  httpService.previewOrder(previewQuery),
              builder: (BuildContext context1, AsyncSnapshot<dynamic> asyncSnapshot){
                if(asyncSnapshot.hasData&&asyncSnapshot.data!=null){
                  
                  var orderJson=Map<String,dynamic>.from(asyncSnapshot.data) ;
                  if(orderJson["Msg"]!=null&&orderJson["Msg"].isNotEmpty){
                    return Container(
                      child:Text(orderJson["Msg"]),
                    );
                  } else if(orderJson["order_id"]!=null||orderJson["order_id"].isNotEmpty){
                    var previewOrder=order.fromJson(orderJson);
                    item_order_type= previewOrder.items[0].xtype;

                    Map<String,dynamic> data={
                      "store_id":previewOrder.storeId,
                    };
                    var formresult;
                       var form_optionsPro= FormOptionsProvider();

                    formGet() async{
                     data["type"]="order" + (item_order_type > 0 ? item_order_type.toString() : '') ;
                     formresult= formconfig.fromJson(await  httpService.formGet(data))  ;
                    //  print("formresult22222222222222 ${formresult.toJson()}");
                     if(formresult.Msg=="ok"){
                       form_optionsPro.addFormList(formresult.form_options);
                     }
                    }
                    formGet();
                    // var form_pro=Provider.of<FormOptionsProvider>(context1);
                    // print("formresult ${form_pro.form_options.toString()}");
                    return ChangeNotifierProvider.value(
                      value: form_optionsPro, 
                      child:Consumer<FormOptionsProvider>(builder: (context, provider, _) {
                        //  print("formresultffffffff ${provider.form_options.runtimeType}");
                        var formData;
                        if(provider.form_options!=null&&provider.form_options.isNotEmpty){
                          formData=provider.form_options;
                        }
                        return Column(
                          children: [
                            
                            if(previewOrder!=null&&previewOrder.items!=null&&previewOrder.items.isNotEmpty&&previewOrder.items.length>0)
                              Container(
                                height:(height-130),
                                child:
                                new ListView(
                                  children: <Widget>[
                                    if(addressObj!=null)
                                      Container(
                                        key:ValueKey(addressObj.address_id),
                                        child:InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, "/address/list/index");
                                          },
                                          child: new AddressShow(
                                            key:ValueKey(addressObj.address_id),
                                            switchable:false,
                                            list:[
                                              new AddressInfo(
                                              name: addressObj.real_name,
                                              tel: addressObj.mobile,
                                              province: addressObj.province,
                                              city: addressObj.city,
                                              county: addressObj.district,
                                              addressDetail: addressObj.address,
                                              isDefault: false),
                                            ],
                                            onClick:(){
                                              Navigator.pushNamed(context, "/address/list/index").then(( addressInfo1){
                                                setState(() {
                                                  address_id=addressInfo1;
                                                });
                                              });
                                            }
                                          ),
                                        )
                                        
                                      ),
                                    if(previewOrder!=null&&previewOrder.items.length>0)
                                      for(var item in previewOrder.items)
                                        NCard(
                                        title: item.title,
                                        desc: item.skuProperties,
                                        num: item.quantity,
                                        price: item.payment,
                                        image: Image.network(item.image)),
                                    if(provider.form_options!=null&&provider.form_options.isNotEmpty)
                                        for(var form in provider.form_options)
                                          (form.type=="text"||form.type=='idcard')?FieldForm(form,provider,context):((form.type=="mobile")?FieldForm(form,provider,context):Container())
                                              
                                          
                                  ],
                                )
                              ),  
                            

                            SubmitBar(buttonText: "提交订单", price: previewOrder.payment,onSubmit: (){
                                  var orderData = {
                                    "order_id": previewOrder.orderId
                                  };
                                  FormDataAdd(provider, previewOrder, (formRes){
                                      httpService.confirmOrder(orderData).then((orderResult){
                                        var confirmOrder = order.fromJson(orderResult);
                                        print("confirmOrder ${confirmOrder.toJson()}");
                                        if(confirmOrder.orderId!=null&&confirmOrder.orderId.isNotEmpty){
                                          if(formRes!=null&&formRes.isNotEmpty){
                                            var form_data = {
                                                "data_id": formRes["data_id"],
                                                "order_id": previewOrder.orderId,
                                                "new_order_id": confirmOrder.orderId
                                            };
                                            httpService.formDataUpdate(form_data).then((formUpRes){
                                              print("formUpRes ${formUpRes.toString()}");
                                            });
                                          }
                                          
                                        }else{
                                          WeNotify.error(context)(
                                              child: Text("下单失败")
                                          );
                                        }
                                        
                                      });
                                  });
                                  
                              // print("skusQuery ${orderSkuPro.skusQuery.toString()}");
                              // orderSkuPro.skusQuery[0].sku_num+=1;
                              // print("previewQuery ${previewQuery['buy_para'].runtimeType}");
                              // if(previewQuery['buy_para'].runtimeType.toString()=='String'){
                              //   print("11111111111111");
                              //   previewQuery['buy_para']=jsonDecode(previewQuery['buy_para']);
                              // }
                              // print("previewQuery ${previewQuery['buy_para'].toString()}");
                              // setState((){
                              //   previewQuery['buy_para']['buy_para'][0]["num"]=2;
                              // });
                            },),
                          ],
                        );
                      })
                    );
                   
                  }
                  
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
    print("router_arguments 11111111111111111${router_arguments.toString()}");
    // List sd=[];
    // sd.isNotEmpty
    var buy_para=[];
    if(router_arguments['orderSkuPro']!=null){
      orderSkuPro= router_arguments['orderSkuPro'];
    }
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
        child:SingleChildScrollView(
          child:  previewOrderAdd(previewOrderQuery,context)
        )
      ),
    );
  }
  
}
