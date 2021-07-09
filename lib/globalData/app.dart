import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
class App extends ChangeNotifier{
  Map config ;
  App({this.config});
  
  setConfig(config){
    this.config=config;
    notifyListeners();
  }
  initConfig() async{
    if(this.config==null){
      print("3333333333");
      Map<String,dynamic> _config;
      try{
        Future<String> loadConfigJson() async {
              return rootBundle.loadString('assets/config/config.json');
        }
        _config=jsonDecode(await loadConfigJson());
        this.setConfig(_config);
      }catch(e){

      }
     print("config33333333333 ${_config}");
     
    }
    return this.config;
  }
}