import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/main.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/pub_item_pack.dart' show Items, Skus;
import 'package:myappflutter/model/skuItem/goods_details_model.dart';
import 'package:myappflutter/util/sku_dialog.dart';
import 'package:myappflutter/globalData/sku_provider.dart';
import 'package:provider/provider.dart';

class Sku {
  var item_id,context;
  var allkeys={},//属性集
        propsval={},//规格
        oneSkuDefaultSelected,
        data={},
        itemSkuData=new Map<String,dynamic>(),
        SKUResult={}, //保存最后的组合结果信息
        theSelectedSku={}, //
        skusPros= {};
        
  double price=0;
  Items item_data; //商品数据
  SkuProvider skuProvider;
  var oneSkuDefaultSelectedSku=new Skus();
  HttpService httpService;
  Sku(context){
    this.context=context;
    httpService=new HttpService();
  }
  initItem(itemId,modalType){
    //modalType 1购买 0购物车
    item_id=itemId;
    var zsku=this;
    httpService.itemOneGet(itemId).then((data){
       //移除禁用的sku
          //跳过无效的sku和库存为0的sku
          // data =new Map<String, dynamic>.from(data);
          // print("data...... ${data}" );
          // print("data222...... ${data['skus']}" );
          // ignore: deprecated_member_use
          var vskus = new List<Skus>();
          // var sku_id =new List<String>();
          data.skus.forEach((one) {
            // print("one ${json.encode(one)}");
            // one = Map<String,dynamic>.from(one);
            if (one.status_id == 1 && one.sku_stocks > 0) {
              // print("onetype ${one.runtimeType}");
              // Map map1=Map<String,dynamic>.from(one);
              // print("111${json.encode(one)}");
              // Skus skus=Skus.fromJson(map1);
              vskus.add(one);
              // sku_id.add(one.sku_id);
            }
          });
          // var newjsonsku=Map<String,dynamic>.from(vskus);
          data.skus = vskus;
          // print("222222222222222,${vskus[0].sku_id}");
          item_data = data;
          // //如果只有1个sku的话，默认选中
          // print("data type ${data.runtimeType}");
          this.oneSkuDefaultSelected = (data.skus.length == 1)  ;
          // print("one ${oneSkuDefaultSelected}");
          var ttt = 0;
          zsku.itemSkuData["skus"]=[];
          zsku.itemSkuData["goods"]=new List();
          data.skus.forEach( (one) {
            ttt++;
          //   // //console.log("sku---", one)
            var kids = [];
            var knames= [];
            var a = one.sku_properties.split(";");
            // print("one ${one}");
            a.forEach( (b) {
              if (b.isEmpty) return;
              var kkk = false;
              if (ttt == 1) {
                if (oneSkuDefaultSelected) {
                  kkk = true;
                }
              }
              var c = b.split(":");
              // print("old zsku.itemSkuData['goods']${zsku.itemSkuData['goods'].toString()}");
              // 
              // zsku.itemSkuData['goods'].asMap().entries.map((index){
              //   print("inde ${index}");
              // });
              // zsku.itemSkuData['goods'].asMap().values.map((val){
              //   print("val ${val}");
              // });
              // print("keys ${zsku.itemSkuData['goods'].asMap().values.indexOf('颜色分类')}");
              if(zsku.itemSkuData["goods"].isEmpty){
                var sku1={};
                sku1["items"]=[];
                sku1["name"]=c[2];
                sku1["items"].add(c[3]);
                zsku.itemSkuData["goods"].add(Map<String,dynamic>.from(sku1));
                // zsku.itemSkuData["goods"][c[2]].add(c[3]);
              }else{
                var i=zsku.itemSkuData["goods"].indexWhere((item){
                  return item['name']==c[2];
                });
                if(i!=-1){
                  if(zsku.itemSkuData["goods"][i]["items"].indexOf(c[3])==-1){
                    zsku.itemSkuData["goods"][i]["items"].add(c[3]);
                  }
                }else{
                  var sku1={};
                  // sku1[c[2]]=[];
                  // sku1[c[2]].add(c[3]);
                  // zsku.itemSkuData["goods"].add(Map<String,dynamic>.from(sku1));
                  sku1["items"]=[];
                  sku1["name"]=c[2];
                  sku1["items"].add(c[3]);
                  zsku.itemSkuData["goods"].add(Map<String,dynamic>.from(sku1));
                }
              }
              
              zsku.propsval[c[0]] = c[2];
              print("c ${c}");
              // // console.error("cccc",c);
              zsku.allkeys[c[0]] = zsku.allkeys[c[0]] ?? {};
              zsku.allkeys[c[0]][c[1]] = {
                "id": c[1],
                "name": c[3],
                "disabled": false,
                "selected": kkk
              };
              knames.add(c[3]);
              kids.add(c[1]);
            });
            if (zsku.oneSkuDefaultSelectedSku.getSkuid==false) {
              zsku.oneSkuDefaultSelectedSku = one;
            }
            if(zsku.itemSkuData["skus"].isEmpty){
                var sku= {
                  "sku":knames.join(";"),
                  "price": one.sku_price,
                  "count": one.sku_stocks,
                  "sku_id": one.sku_id,
                  "img":one.imgurl

                };  

                zsku.itemSkuData["skus"].add(sku);
            }else{
              var sku= {
                  "sku":knames.join(";"),
                  "price": one.sku_price,
                  "count": one.sku_stocks,
                  "sku_id": one.sku_id,
                  "img":one.imgurl
                };  
                var i=zsku.itemSkuData["skus"].indexWhere((item){
                  return item['sku_id']==sku['sku_id'];
                });
                if(i==-1){
                  zsku.itemSkuData["skus"].add(sku);
                }
            }
            kids.sort( (a,b)=> a.compareTo(b));
            zsku.data[kids.join(";")] = {
              "price": one.sku_price,
              "count": one.sku_stocks,
              "sku_id": one.sku_id
            };
             zsku.price = one.sku_price;

          });
          // // zsku.cd.detectChanges();
          // // console.log("初始化状态：", zsku.price);
          // print("zsku.allkeys ${zsku.allkeys.toString()}");
          // print("zskudata ${zsku.data.toString()}");
          // print("zsku.itemSkuData ${zsku.itemSkuData.runtimeType}");
          GoodsDetailsModel goodsDetailsModel = GoodsDetailsModel.fromJson(zsku.itemSkuData);
          // print("goodsDetailmodel ${goodsDetailsModel.toJson()}");
          skuProvider = SkuProvider(goodsDetailsModel);
          var list = goodsDetailsModel.goods.map((item) => item.name).toList();
          // skuProvider.selectedSku = "请选择\t${list.join("，")}";
          // print("curritem");
          skuProvider.currentItem = data;
          skuProvider.setModalType(modalType);
          // print("showItemDialog");
          this.showItemDialog((){

          });
          // if (zsku.oneSkuDefaultSelected && zsku.oneSkuDefaultSelectedSku.sku_id) {
          //   // console.error("oneSkuDefaultSelected", zsku.oneSkuDefaultSelectedSku);
          //   zsku.theSelectedSku = zsku.oneSkuDefaultSelectedSku;
          //   console.error("theSelectedSku", zsku.theSelectedSku);
          //   zsku.skuSelected(zsku.oneSkuDefaultSelectedSku);
          //   zsku.$set(zsku.theSelectedSku,'num',1)
          //   // zsku.theSelectedSku.num = 1;
          //   console.error("vm",zsku);
          //   zsku.$emit("sku-callback",zsku.theSelectedSku);
          // }

          // zsku.skusPros = zsku.allkeys;
          // zsku.pros = zsku.propsval;
          // //zsku.skus = Object.keys(zsku.allkeys);
          // // console.log("skusPros:", zsku.skusPros, zsku.price);
          // print("data:", zsku.data);
    });
  }
  showItemDialog(cb){
    showModalBottomSheet(
      context: context,
      isScrollControlled :true,
      useRootNavigator: true,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 380),
          child:ChangeNotifierProvider.value(value: skuProvider, child: SkuDialog())
        );
      }
    );
    // ActionSheet(
    //   child:  ChangeNotifierProvider.value(value: skuProvider, child: SkuDialog()),
    //   // title:"222",
    //   closeIcon: Icons.highlight_off,
    // ).show(context);
  }
}
class SkuPage extends StatefulWidget{
  @override
  _Sku createState() => new _Sku();
}
class _Sku extends State<SkuPage>{
  @override
  String item_id;
  SetItem_id(itemid,context){
    ActionSheet(
        child: Container(
          height: 150,
          padding: EdgeInsets.all(10),
          alignment: AlignmentDirectional.topStart,
          child: Text("data"),
        ),
        // title:"222",
        closeIcon: Icons.highlight_off,
      ).show(context);
  }
  Widget build(BuildContext context) {
    // Sku(context).initItem(item['item_id']);
    return ActionSheet(
        child: Container(
          height: 150,
          padding: EdgeInsets.all(10),
          alignment: AlignmentDirectional.topStart,
          child: Text("data"),
        ),
        // title:"222",
        closeIcon: Icons.highlight_off,
      ).show(context);
    }
}