import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/actionSheet.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/pub_item_pack.dart' show Items, Skus;

class Sku {
  var item_id,context;
  var allkeys={},//属性集
        propsval={},//规格
        oneSkuDefaultSelected,
        data={},
        itemSkuData={},
        SKUResult={}, //保存最后的组合结果信息
        theSelectedSku={}, //
        price=0,
        skusPros= {};
  Items item_data; //商品数据
  var oneSkuDefaultSelectedSku=new Skus();
  HttpService httpService;
  Sku(context){
    context = context;
    // _Sku createState() => new _Sku();
    httpService=new HttpService();
  }
  initItem(itemId){
    item_id=itemId;
    var zsku=this;
    print("rukou11111");
    httpService.itemOneGet(itemId).then((data){
       //移除禁用的sku
          //跳过无效的sku和库存为0的sku
          print("data${json.encode(data)}");
       
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
          // print("222222222222222,${sku_id}");
          print("dddd ${vskus}");
          item_data = data;
          // //如果只有1个sku的话，默认选中
          print("item_data ${item_data}");
          // print("data type ${data.runtimeType}");
          this.oneSkuDefaultSelected = (data.skus.length == 1)  ;
          print("one ${oneSkuDefaultSelected}");
          var ttt = 0;
          data.skus.forEach( (one) {
            ttt++;
          //   // //console.log("sku---", one)
            var kids = [];

            var a = one.sku_properties.split(";");
            print("aaa${a}");
          //   // //console.log("aaaaaaa",a);
            a.forEach( (b) {
              if (b.isEmpty) return;
              print("bbbb${b}");
              var kkk = false;
              if (ttt == 1) {
                if (oneSkuDefaultSelected) {
                  kkk = true;
                }
              }
              var c = b.split(":");
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
              kids.add(c[1]);
            });
            if (zsku.oneSkuDefaultSelectedSku.getSkuid==false) {
              zsku.oneSkuDefaultSelectedSku = one;
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
          print("zsku.allkeys ${zsku.allkeys.toString()}");
          print("zskudata ${zsku.data.toString()}");
          zsku.initSKU();

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
  initSKU() {
      var i,
        j,
        skuKeys = this.getObjKeys(this.data);
      for (i = 0; i < skuKeys.length; i++) {
        var skuKey = skuKeys[i]; //一条SKU信息key
        var sku = this.data[skuKey]; //一条SKU信息value
        var skuKeyAttrs = skuKey.split(";"); //SKU信息key属性值数组
        var len = skuKeyAttrs.length;
        // //console.error("=========fdsafsdafsa")

        // //对每个SKU信息key属性值进行拆分组合
        // var combArr = this.arrayCombine(skuKeyAttrs);
        // for (j = 0; j < combArr.length; j++) {
        //   this.add2SKUResult(combArr[j], sku);
        // }

        // //结果集接放入this.SKUResult
        // this.SKUResult[skuKey] = {
        //   count: sku.count,
        //   prices: [sku.price]
        // };
      }

    // //初始化disabled和selected
    // // //console.error("=========fdsafsdafsa", this.allkeys)
    // for (let index in this.allkeys) {
    //   var elem = this.allkeys[index];

    //   // //console.error(index, elem)
    //   for (let k in elem) {
    //     // //console.error(elem[k], k)
    //     if (!this.SKUResult[k]) {
    //       this.allkeys[index][k].disabled = true;
    //     }
    //   }
    // }
// //console.error("初始化完成的数组：", this.SKUResult, this.allkeys)
  }
  arrayCombine(targetArr) {
    if (!targetArr || !targetArr.length) {
      return [];
    }

    var len = targetArr.length;
    var resultArrs = [];

    // 所有组合
    // for (var n = 1; n < len; n++) {
    //   var flagArrs = this.getFlagArrs(len, n);
    //   while (flagArrs.length) {
    //     var flagArr = flagArrs.shift();
    //     var combArr = [];
    //     for (var i = 0; i < len; i++) {
    //       flagArr[i] && combArr.add(targetArr[i]);
    //     }
    //     resultArrs.add(combArr);
    //   }
    // }

    return resultArrs;
  }
  //
  getFlagArrs(m, n) {
    if (!n || n < 1) {
      return [];
    }

    var resultArrs = [],
      flagArr = [],
      isEnd = false,
      i,
      j,
      leftCnt;

    for (i = 0; i < m; i++) {
      flagArr[i] = i < n ? 1 : 0;
    }

    resultArrs..addAll(flagArr);

    // while (!isEnd) {
    //   leftCnt = 0;
    //   for (i = 0; i < m - 1; i++) {
    //     if (flagArr[i] == 1 && flagArr[i + 1] == 0) {
    //       for (j = 0; j < i; j++) {
    //         flagArr[j] = j < leftCnt ? 1 : 0;
    //       }
    //       flagArr[i] = 0;
    //       flagArr[i + 1] = 1;
    //       var aTmp = [...flagArr];
    //       resultArrs.add(aTmp);
    //       if (
    //         aTmp
    //           .slice(-n)
    //           .join("")
    //           .indexOf("0") == -1
    //       ) {
    //         isEnd = true;
    //       }
    //       break;
    //     }
    //     flagArr[i] == 1 && leftCnt++;
    //   }
    // }
    return resultArrs;
  }
  //获取所有key的方法
  getObjKeys(obj) {
    if(obj.isEmpty) return false;
    // if (obj !== Object(obj)) throw new TypeError("Invalid object");
    var keys = [];
    obj.forEach((key,val){
      print('key ${key}');
      print('val ${val}');
      if (obj.containsKey(key)){
        print("|9999999999");
        keys.add(key);
        // keys[keys.length] = key;
      }
    });
    // for (var key in obj){
    //   if (obj.containsKey(key)){
    //     keys[keys.length] = key;
    //   }
    // }
    return keys;
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