import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/actionSheet.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/item_pack.dart';
import 'package:myappflutter/model/pub_item_pack.dart' show SKus;

class Sku {
  var item_id,context;
  var allkeys={},//属性集
        oneSkuDefaultSelectedSku={},
        oneSkuDefaultSelected,
        data={},
        SKUResult={}, //保存最后的组合结果信息
        item_data={}, //商品数据
        theSelectedSku={}, //
        skusPros= {};
  HttpService httpService;
  Sku(context){
    context = context;
    // _Sku createState() => new _Sku();
    httpService=new HttpService();
  }
  initItem(itemId){
    item_id=itemId;
    httpService.itemOneGet(itemId).then((data){
       //移除禁用的sku
          //跳过无效的sku和库存为0的sku
          print("data${json.encode(data)}");
       
          // data =new Map<String, dynamic>.from(data);
          // print("data...... ${data}" );
          // print("data222...... ${data['skus']}" );
          List vskus = [];
          data.skus.forEach((one) {
            print("one ${json.encode(one)}");
            // one = Map<String,dynamic>.from(one);
            if (one.status_id == 1 && one.sku_stocks > 0) {
              print("onetype ${one.runtimeType}");
              // Map map1=Map<String,dynamic>.from(one);
              // print("3333333333333333");
              // Skus skus=Skus.fromJson(map1);
              vskus.add(one);
            }
          });
          // var newjsonsku=Map<String,dynamic>.from(vskus);
          data.skus = List<Skus>.from(vskus);
          print("222222222222222");
          this.item_data = data;
          // //如果只有1个sku的话，默认选中
          print("item_data ${item_data}");
          // print("data type ${data.runtimeType}");
          // this.oneSkuDefaultSelected = (data['skus'].length == 1)  ;
          // var ttt = 0;
          // data['skus'].forEach( (one) {
          //   ttt++;
          //   // //console.log("sku---", one)
            // var kids = [];

            // var a = one['sku_properties'].split(";");
          //   // //console.log("aaaaaaa",a);
          //   a.forEach( (b) {
          //     if (!b) return;
          //     var kkk = false;
          //     if (ttt == 1) {
          //       if (oneSkuDefaultSelected) {
          //         kkk = true;
          //       }
          //     }
          //     var c = b.split(":");
          //     zsku.propsval[c[0]] = c[2];
          //     console.error("cccc",c);
          //     zsku.allkeys[c[0]] = zsku.allkeys[c[0]] || {};
          //     zsku.allkeys[c[0]][c[1]] = {
          //       id: c[1],
          //       name: c[3],
          //       disabled: false,
          //       selected: kkk
          //     };
          //     kids.push(c[1]);
          //   });

          //   if (!zsku.oneSkuDefaultSelectedSku.sku_id) {
          //     zsku.oneSkuDefaultSelectedSku = one;
          //   }

          //   kids.sort(function (a, b) {
          //     return a - b;
          //   });
          //   zsku.data[kids.join(";")] = {
          //     price: one.sku_price,
          //     count: one.sku_stocks,
          //     sku_id: one.sku_id
          //   };
          //   zsku.price = one.sku_price;
          // });
          // // zsku.cd.detectChanges();
          // // console.log("初始化状态：", zsku.price);
          // zsku.initSKU();

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
    print("888888888888");
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