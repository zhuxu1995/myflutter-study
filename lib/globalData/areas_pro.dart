import 'package:flutter/material.dart';
import 'package:myappflutter/component/picker.dart';
import 'package:myappflutter/model/address/address.dart';
import 'package:myappflutter/pages/address/add.dart';

class AreasPro with ChangeNotifier{
  List<PickerItem> areasData=[];
  List<int> citysIndex=[];
  List<int> citysId=[];
  addArea(data){
    areasData.add(data);
    notifyListeners();
  }
  update(list,{indexs,ids}){
    areasData=[];
    citysIndex=[];
    citysId=[];
    areasData=list;
    if(indexs!=null&&indexs.length>0){
      citysIndex=indexs;
    }
    if(ids!=null&&ids.length>0){
      citysId=ids;
    }
    notifyListeners();
  }
}
class AddressPro with ChangeNotifier{
  Deliver_addrs address_info;
  setAddress(info){
    if(info.runtimeType.toString()=='Deliver_addrs'){
      address_info=info;
    }else{
      address_info=Deliver_addrs.fromJson(info);
    }
    notifyListeners();
  }
  init(){
    notifyListeners();
  }
}