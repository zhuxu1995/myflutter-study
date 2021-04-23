import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
}