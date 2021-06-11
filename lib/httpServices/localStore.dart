import 'package:flutter/cupertino.dart';
import 'package:myappflutter/globalData/member.dart';
import 'package:myappflutter/model/member/member_value.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:convert' as convert;

import '../main.dart';
class DhflocalStore {
  //  dhflocalStore(){
  //  prefs =   SharedPreferences.getInstance();
  // }
  SharedPreferences prefs;
  DhflocalStore() {
    initConfig();
  }
  initConfig() async{
    prefs=await SharedPreferences.getInstance();
  }
  setToken(String token) async{
    await prefs.setString("token", token);
  }
   getChijiuObject() async{
    return prefs;
  }
  getToken() async {
    var val =prefs.getString("token");
    print("222222 ${val}");
    return  val??"";
  }
  setData(key,data,{int ttl,int exp,bool noprev}) async{
    if(!noprev){
      key=this.getKeyName(key);
    }
    ttl = ttl * 1;
    print("${key} ttl ${ttl}");
    if (ttl!=0) {
        ttl = ttl + this.timeSecond() * 1;
    } else {
        exp = exp * 1;
        if (exp!=0) {
            ttl = exp;
        } else {
            ttl = 0;
        }
    }
    getData(key).then((result){
      List list = List<String>();
      if(result!=null){
        list = result;
      }
      list.add(convert.jsonEncode(data));
      prefs.setStringList(key, list);
    });
  }
  getCurrentUserInfo() async {
    return getData("currentUserInfo").then((memberList){
     return  !memberList.isEmpty?memberList[0]:null;
    });
  }
  getData(key,{int ttl,int exp,bool noprev})async{
    if(!noprev){
      key=this.getKeyName(key);
    }
    var list=prefs.getStringList(key);
    List new_list=List();
    list.forEach((value){
      Map<String,dynamic> item1 =convert.jsonDecode(value);
      new_list.add(item1);
    });
    return new_list;
  }
  timeSecond() {
        var a = new DateTime.now();
        return a.millisecondsSinceEpoch;
  }
  getKeyName(keyname){
    return this.__KeyName(keyname);
  }

  //设置命名空间
  setNameSpace(a) async{
      prefs.setString("member_id", a);
  }

  //读取命名空间
  getNameSpace() {
      return prefs.getString("member_id");
  }
   
  String __KeyName(keyName){
    var memberId = 0;
    BuildContext context = navigatorKey.currentState.overlay.context;
    MemberModel memStr= Provider.of<MemberModel>(context,listen: false);
    memberValue member;
    if(memStr.getMember()!=null){
      member=memberValue.fromJson(memStr.getMember());
    }
    if (member!=null && member.memberId>0) {
        memberId = member.memberId;
    }
    if (memberId == 0) {
        memberId = this.getNameSpace();
    }
    return "P" + memberId.toString() + "_" + keyName;
  }
}