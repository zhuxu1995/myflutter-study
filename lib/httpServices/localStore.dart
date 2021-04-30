import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:convert' as convert;
class DhflocalStore {
  //  dhflocalStore(){
  //  prefs =   SharedPreferences.getInstance();
  // }
  
  setToken(String token) async{
    print("token: $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setToken: $token");
    await prefs.setString("token", token);
  }
   getChijiuObject() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
  getToken() async {
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    String val =prefs.getString("token");
    print("token:value:$val");
    return  val;
  }
  setData(key,data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      print("memberList ${memberList.isEmpty }");
     return  !memberList.isEmpty?memberList[0]:null;
    });
  }
  getData(key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list=prefs.getStringList(key);
    List new_list=List();
    list.forEach((value){
      Map<String,dynamic> item1 =convert.jsonDecode(value);
      new_list.add(item1);
      print("$new_list");
    });
      print("fffd $new_list");
    return new_list;
  }
}