import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vant_kit/theme/style.dart';
import 'package:flutter_vant_kit/widgets/button.dart';
import 'package:flutter_vant_kit/widgets/cell.dart';
import 'package:flutter_vant_kit/widgets/cellGroup.dart';
import 'package:flutter_vant_kit/widgets/field.dart';
import 'package:myappflutter/component/picker.dart';
import 'package:myappflutter/component/pickerView.dart';
import 'package:myappflutter/globalData/areas_pro.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/address/address.dart';
import 'package:myappflutter/model/areas/areasmodel.dart';
import 'package:myappflutter/packages/weui/notify/index.dart';
import 'package:provider/provider.dart';

class AddressPageAdd extends StatelessWidget{
  // ignore: missing_return
  var address_id;
  var address_info;
    HttpService httpService=new HttpService();
  
  @override
  Widget build(BuildContext context){
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;

    if(router_arguments!=null&&router_arguments.isNotEmpty&&router_arguments['address_id']!=null){
      address_id = router_arguments['address_id'];
    }
    return Scaffold(
      appBar: AppBar(),
      body:new AddressAddForm(
        address_id: address_id,
        saveButtonText:"保存地址",
        onSave: (info){
          if(address_id!=null){
            info["address_id"]=address_id;
            httpService.addressUpdate(info).then((res){
              print("res ${res.toString()}");
              if(res["address_id"]!=null){
                  WeNotify.success(context)(
                    onColse:(){
                      Navigator.pop(context,{"address_id":res['address_id']});
                    },
                    child: Text("修改成功")
                  );
              }else{
                  WeNotify.error(context)(
                    child: Text(res['Msg'])
                  );
              }
            });
          }else{
            httpService.addressAdd(info).then((res){
              print("res ${res.toString()}");
              if(res["address_id"]){
                  WeNotify.success(context)(
                    child: Text("创建成功"),
                    onColse:(){
                      Navigator.pop(context,{"address_id":res['address_id']});
                    },
                  );
              }else{
                  WeNotify.error(context)(
                    child: Text(res['Msg'])
                  );
              }
            });
          }
          
        },
      ),
    );
  }
  
}
class AddressAddForm extends StatefulWidget{
  var address_id;
  var address_info;
  final String saveButtonText;
  final Function(Map map) onSave;
  @override
  _AddressAddForm createState() =>_AddressAddForm();
  AddressAddForm({this.address_id,this.address_info,this.saveButtonText,this.onSave});
  
}
class _AddressAddForm extends State<AddressAddForm>{
  @override
  var _id;
  HttpService httpService=new HttpService();
  AreasPro areaPro = new AreasPro();
  Map input = {
    "real_name": TextEditingController(),
    "phone": TextEditingController(),
    "area": TextEditingController(),
    "address": TextEditingController(),
    "postalCode": TextEditingController(),
  };
  bool setDefaultAddress = false;
  List<int> _cityId = [];//省市区下标集合
  List<int> _areaId=[];//省市区Id集合
  List<String> areasNames = [];//选中省市名集合

  Map<String, dynamic> _addressInfo;
  AddressPro addressPro=new AddressPro();
  AddressOneGet(addressId ,cb) async{
   var result=  await httpService.addressGet({"query":{"address_id":addressId}});
   if(result!=null&&result['deliver_addrs'].isNotEmpty){
    await addressPro.setAddress(result['deliver_addrs'][0]);
    setState(() {
      _addressInfo=addressPro.address_info.toJson();
    });
   }
   cb(addressPro);
  }
  void initState() {

    _id = widget.address_id;
     _addressInfo={};
    //  var context=this.context;
    if(_id!=null){
      AddressOneGet(_id,(addressPro){
        _addressInfo = (addressPro.address_info!=null)? addressPro.address_info.toJson() : {};
        areasNames=[];
        _areaId=[];
        _areaId.add(0);
        _addressInfo.forEach((key, value) {
          if (["province", "city", "district"].contains(key) && value != null)
            areasNames.add(value);
          if (["province_id", "city_id", "district_id"].contains(key))
            _areaId.add(value ?? 0);
          if (["real_name", "phone", "address"].contains(key) &&
              value != null) input[key].text = value;
          if(["is_default"].contains(key) &&
              value != null) input[key]=value;
        });
        
        print("_addressInfo ${_addressInfo.toString()}");
        input['area'].text = areasNames.join('/');
        var areaDataObj= AreaZuZhuangData(areaPro,areasId:_areaId,areasName:areasNames);
        areaDataObj.provinceGet(initStatus:(_id!=null&&_id!='')?true:false).then((res){
          print("结果：${areaPro.citysId}");
          if(areaPro.citysId!=null&&areaPro.citysId.length>0){
            _areaId=areaPro.citysId;
          }
        }); 
      }); 
       
    }else{
      var areaDataObj= AreaZuZhuangData(areaPro,areasId:_areaId,areasName:areasNames);
      areaDataObj.provinceGet(initStatus:(_id!=null&&_id!='')?true:false); 
    }
    super.initState();
    
  }

  getContent() {
    Map<String, dynamic> map = {};
    ["real_name", "phone", "address", "postalCode"].forEach((value) {
      map[value] = input[value].text;
    });
    List areas = input['area'].text.split('/');
    map['province'] = areas[0] ?? "";
    if(_areaId!=null&&_areaId.length>0){
      map['province_id'] = _areaId[0];
    }
    map['provinceId'] = _cityId[0];
    map['city'] = areas[1] ?? "";
    if(_areaId!=null&&_areaId.length>1){
      map['city_id'] = _areaId[1];
    }
    map['district'] = areas[2] ?? "";
    if(_areaId!=null&&_areaId.length>2){
      map['district_id'] = _areaId[2];
    }
    map["is_default"] = _addressInfo['isDefault'];
    _addressInfo = map;
    return map;
  }

  Widget buildNameField(){
    return Field(
      label: "姓名",
      placeholder: "收货人姓名",
      controller: input['real_name'],
    );
  }
  Widget buildPhoneField() {
    return Field(
      label: "手机号",
      placeholder: "收货人手机号",
      controller: input['phone'],
      keyboardType: TextInputType.phone,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11)
      ],
    );
  }
  var loading1=false;
  int level=3;

   colseloaddding(){
     setState(() {
        loading1=false;
    });
  }
  Widget buildAreaField() {
    
    return Field(
      label: "地区",
      placeholder: "省/市/区 选择",
      rightIcon: Icons.chevron_right,
      controller: input['area'],
      readonly: true,
      onClick: () async{
        print("_areaId ${_areaId}");
        print("areasNames ${areasNames}");
        // var areaDataObj= AreaZuZhuangData(areaPro,areasId:_areaId,areasName:areasNames);
        // print("_id ${_id}");
        // await areaDataObj.provinceGet(initStatus:(_id!=null&&_id!='')?true:false);
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              print("_id${_id.runtimeType}");
              print("leng ${_cityId.join('-')}");
              if(_cityId==null||(_cityId.runtimeType.toString().indexOf('List')!=-1&&_cityId.length==0)){
                _cityId=[0,0,0];
              }
              return ChangeNotifierProvider.value(
                      value: areaPro, 
                      child:Consumer<AreasPro>(builder: (context, provider, _) {
                        // print("pro返回");
                        var Areas1= Provider.of<AreasPro>(context);
                        // print("pro返回 ${Areas1.citysIndex}");
                        if(Areas1.citysIndex!=null&&Areas1.citysIndex.length>0){
                          print("初始化");
                          _cityId=Areas1.citysIndex;
                          // print("Areas1.citysIndex ${Areas1.citysIndex}");
                        }
                        if(Areas1.areasData!=null&&Areas1.areasData.length>0){
                          if((Areas1.areasData[_cityId[0]].child==null||Areas1.areasData[_cityId[0]].child.length==0)){
                            level=2;
                          }else if((Areas1.areasData[_cityId[0]].child[_cityId[1]].child!=null&&Areas1.areasData[_cityId[0]].child[_cityId[1]].child.length>1)){
                            level=3;
                          }
                        
                          String key1="areaChoice";
                          if(Areas1.areasData!=null&&Areas1.areasData.length>_cityId[0]){
                              key1+=Areas1.areasData[_cityId[0]].areaId.toString();
                              if(Areas1.areasData[_cityId[0]].child!=null&&Areas1.areasData[_cityId[0]].child.length>_cityId[1]){
                                key1+=Areas1.areasData[_cityId[0]].child[_cityId[1]].areaId.toString();
                                if(Areas1.areasData[_cityId[0]].child[_cityId[1]].child!=null&&Areas1.areasData[_cityId[0]].child[_cityId[1]].child.length>_cityId[2]){
                                  key1+=Areas1.areasData[_cityId[0]].child[_cityId[1]].child[_cityId[2]].areaId.toString();
                                }
                              }
                          }
                          return Picker(
                            key:ValueKey(key1),
                            loading: loading1,
                            colums: Areas1.areasData,
                            level: level,
                            defaultIndex: _cityId,
                            showToolbar: true,
                            onConfirm: (values, index) {
                              _areaId=[];
                              _areaId.add(provider.areasData[index[0]].areaId);
                              _areaId.add(provider.areasData[index[0]].child[index[1]].areaId);
                              _areaId.add(provider.areasData[index[0]].child[index[1]].child[index[2]].areaId);
                              setState(() {
                                input['area'].text = values.join('/');
                                _cityId = index;
                                areasNames=values;
                                // current_Index = index;
                              });
                              Navigator.of(context).pop();
                            },
                            onCancel: (values, index) {
                              Navigator.of(context).pop();
                            },
                            onChange:(values, index)async{
                              print("${values.toString()}");
                              print("index== ${index.toString()}");
                              _cityId=index;
                              // print("当前省总数数据 ${areaPro.areasData.length}");
                              // print("当前市总数数据 ${areaPro.areasData[_cityId[0]].child.length}");
                              // print("当前市名称 ${areaPro.areasData[_cityId[0]].text}");
                              // print("当前地区总数数据 ${areaPro.areasData[_cityId[0]].child[_cityId[1]].child.length}");
                              // print("当前地区名称 ${areaPro.areasData[_cityId[0]].child[_cityId[0]].text}");
                              setState(() {
                                level=2;
                              });
                              AreaZuZhuangData(areaPro).provinceGet(proIndex:_cityId[0],cityIndex:_cityId[1],distIndex:_cityId[2]).then((res1){
                                setState(() {
                                  level=3;
                                });
                              });
                            
                            }
                          );
                        }
                      })
              );
            });
      },
    );
  }
  
  Widget buildAddressInfoField() {
    return Field(
      label: "详细地址",
      placeholder: "街道、门牌号",
      controller: input['address'],
      rows: 2,
      type:"textarea",
    );
  }
  Widget buildSetDefault() {
    return Cell(
      title: "设为默认收货地址",
      customRight: SizedBox(
        height: Style.addressEditSwitchHeight,
        child: CupertinoSwitch(
          value: (_addressInfo!=null&&_addressInfo["is_default"]==1)?true: false,
          activeColor: Style.addressEditSwitchColor,
          onChanged: (bool value) {
            setState(() {
              _addressInfo["is_default"] = value?1:0;
            });
          },
        ),
      ),
    );
  }
  Widget buildSaveButton() {
    return NButton(
      text: widget.saveButtonText,
      round: true,
      block: true,
      type: "danger",
      onClick: () {
        if (widget.onSave != null) widget.onSave(getContent());
      },
    );
  }
  
  Widget build(BuildContext context) {
    print("_id ${_id}");
    print("_info ${_addressInfo}");

    return 
    Column(
      children: [
        CellGroup(
            border: false,
            children: <Widget>[
              buildNameField(),
              buildPhoneField(),
              buildAreaField(),
              buildAddressInfoField(),
              buildSetDefault(),
              buildSaveButton()
            
            ],
        ),
      ],
    );
  }

}

class AreaZuZhuangData {
  HttpService httpService=new HttpService();
  AreasPro areaPro ;
  List<int> areasId=[];
  List<String> areasName=[];
  AreaZuZhuangData(this.areaPro,{this.areasId,this.areasName});
  provinceGet({proIndex=0,cityIndex=0,distIndex=0,initStatus=false}) async{
    List <int> citysId=[];
    var query={
      "query":{
        "parent_id":0
      },
      "page_size":35
    };
    List<PickerItem> new_provinces_list=[],new_citys_list=[],new_dist_list=[];
    List<PickerItem> provinces_list=[],citys_list=[],dist_list=[];
    var provinces;
    if(areaPro.areasData.isEmpty&&areaPro.areasData.length==0){
      print("初始化");
      return  httpService.areaGet(query).then((res) async{
        provinces=Areasmodel.fromJson(res);
        // for (var province in provinces.areas)
        //   provinces_list.add(WePickerItem(label:province.area,value:province.areaId.toString()));
        var citys;
        var dists;
        List<int> ids=[];
        if(initStatus){
          var province_id;
          if(provinces.areas!=null&&provinces.areas.length>0){
            for (var i = 0; i <provinces.areas.length; i++) {
              if(provinces.areas[i].area==areasName[0]){
                  citysId.add(i);
                  province_id=provinces.areas[i].areaId;
                  ids.add(provinces.areas[i].areaId);
                }
            }
          }
          citys= await ziAreasGet(province_id);
          if(citys.areas!=null&&citys.areas.length>0){
            for (var i = 0; i <citys.areas.length; i++) {
              if(citys.areas[i].area==areasName[1]){
                  citysId.add(i);
                  ids.add(citys.areas[i].areaId);
                }
            }
          }
          dists= await ziAreasGet(areasId[1]);
          if(dists.areas!=null&&dists.areas.length>0){
            for (var i = 0; i <dists.areas.length; i++) {
              print(dists.areas[i].area);
              if(dists.areas[i].area==areasName[2]){
                  citysId.add(i);
                  ids.add(dists.areas[i].areaId);
                }
            }
          }
          // print("citysId------------${citysId}");
        }else{
          citys= await ziAreasGet(provinces.areas[proIndex].areaId);
          dists= await ziAreasGet(citys.areas[cityIndex].areaId);
        }
        for (var dist in dists.areas){
          // print("${dist.area}");
          new_dist_list.add(PickerItem(dist.area,areaId:dist.areaId,parentId:dist.parentId));
        }
        for (var city in citys.areas){
          if(initStatus){
            (city.areaId==citys.areas[citysId[1]].areaId)?new_citys_list.add(PickerItem(city.area,areaId:city.areaId,parentId:city.parentId,child:new_dist_list)):new_citys_list.add(PickerItem(city.area,areaId:city.areaId,parentId:city.parentId));
          }else{
            (city.areaId==citys.areas[cityIndex].areaId)?new_citys_list.add(PickerItem(city.area,areaId:city.areaId,parentId:city.parentId,child:new_dist_list)):new_citys_list.add(PickerItem(city.area,areaId:city.areaId,parentId:city.parentId));
          }
        }
        if(areaPro.areasData==null||areaPro.areasData.length==0){
          if(areaPro.areasData==null){
            areaPro.areasData=[];
          }
          for (var province in provinces.areas){
            if(initStatus){
              (province.areaId==provinces.areas[citysId[0]].areaId)?new_provinces_list.add(PickerItem(province.area,parentId:province.parentId,areaId:province.areaId,child:new_citys_list)):new_provinces_list.add(PickerItem(province.area,parentId:province.parentId,areaId:province.areaId));
            }else{
              (province.areaId==provinces.areas[proIndex].areaId)?new_provinces_list.add(PickerItem(province.area,parentId:province.parentId,areaId:province.areaId,child:new_citys_list)):new_provinces_list.add(PickerItem(province.area,parentId:province.parentId,areaId:province.areaId));
            }
          }
        }else{
          areaPro.areasData[proIndex].upChild(new_citys_list);
          new_provinces_list=areaPro.areasData;
        }
        if(initStatus){
          if((new_provinces_list[citysId[0]].child!=null&&new_provinces_list[citysId[0]].child.length>0)&&(new_provinces_list[citysId[0]].child[citysId[1]].child!=null&&new_provinces_list[citysId[0]].child[citysId[1]].child.length>0)){
            areaPro.update(new_provinces_list,indexs:citysId,ids:ids);
          }
        } else{
          if((new_provinces_list[proIndex].child!=null&&new_provinces_list[proIndex].child.length>0)&&(new_provinces_list[proIndex].child[cityIndex].child!=null&&new_provinces_list[proIndex].child[cityIndex].child.length>0)){
            areaPro.update(new_provinces_list,indexs:citysId);
          }
        }
        
        // "provinces":provinces_list,"citys":citys_list,"dists":dist_list,
        // print("返回结果 ${new_provinces_list.length}");
        // print("返回下标结果 ${citysId}");

        return {"vanPicker":new_provinces_list};
      });
    }else if(cityIndex>=0){
      print("滚动-----------------------------start");
      provinces=areaPro.areasData;

      var dists;
      return  ziAreasGet(provinces[proIndex].areaId).then((citys)async{
        // print("cityName ${citys.areas[cityIndex].area}");
        // print("child ${areaPro.areasData[proIndex].child[cityIndex].child[0].text}");
        if(provinces[proIndex].child!=null&&provinces[proIndex].child.length>0){
          if(provinces[proIndex].child[cityIndex].child==null||provinces[proIndex].child[cityIndex].child.length==0){
            dists= await ziAreasGet(provinces[proIndex].child[cityIndex].areaId);
            for (var dist in dists.areas){
              if(dist.parentId==provinces[proIndex].child[cityIndex].areaId){
                new_dist_list.add(PickerItem(dist.area,areaId:dist.areaId,parentId:dist.parentId));
              }
            }
            provinces[proIndex].child[cityIndex].upChild(new_dist_list);
          }
        }else {
            dists= await ziAreasGet(citys.areas[cityIndex].areaId);
            for (var dist in dists.areas){
                new_dist_list.add(PickerItem(dist.area,areaId:dist.areaId,parentId:dist.parentId));
            }
            for (var city in citys.areas){
              if(city.parentId==provinces[proIndex].areaId){
                if(new_dist_list.length>0){
                  if(new_dist_list[0].parentId==city.areaId){
                    new_citys_list.add(PickerItem(city.area,parentId:city.parentId,areaId:city.areaId,child:new_dist_list));
                  }else{
                    new_citys_list.add(PickerItem(city.area,parentId:city.parentId,areaId:city.areaId,));
                  }
                }else{
                  new_citys_list.add(PickerItem(city.area,parentId:city.parentId,areaId:city.areaId,));
                }
              }
            }
            for (var province in areaPro.areasData){
              if(province.areaId==new_citys_list[0].parentId){
                province.upChild(new_citys_list);
              }
            }
            
        }
        if(areaPro.areasData==null||areaPro.areasData.length==0){
          if(areaPro.areasData==null){
            areaPro.areasData=[];
          }
        }else{
          // areaPro.areasData[proIndex].upChild(new_citys_list);
          // print("child name ${areaPro.areasData[proIndex].child[cityIndex].text}");
          // print("child ${areaPro.areasData[proIndex].child[cityIndex].toJSon()}");
          // print("child ${areaPro.areasData[proIndex].child[cityIndex].child[0].text}");
          // print("index ${distIndex}");
          new_provinces_list=areaPro.areasData;
        }
        if((new_provinces_list[proIndex].child!=null&&new_provinces_list[proIndex].child.length>0)&&(new_provinces_list[proIndex].child[cityIndex].child!=null&&new_provinces_list[proIndex].child[cityIndex].child.length>0)){
          // print("更新通知------------end ${new_provinces_list[proIndex].child[cityIndex].text}");
          areaPro.update(new_provinces_list,indexs:citysId);
        }
        // "provinces":provinces_list,"citys":citys_list,"dists":dist_list,
        return {"vanPicker":new_provinces_list};
      });
    }
  }

  ziAreasGet(area_id){
    var query={
      "query":{
        "parent_id":area_id
      },
      "page_size":100
    };
    return httpService.areaGet(query).then((res){
      var areas=Areasmodel.fromJson(res);
      return areas;
    });
  }
  
}
//扩展组件模型参数
class NewPickerItem extends PickerItem{
  var areaId;
  NewPickerItem(String text,this.areaId,{child}) : super(text,areaId:areaId,child: child);
  
}
