import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:myappflutter/httpServices/localStore.dart';
DhflocalStore dhflocalStore =new DhflocalStore();
class _Headers  {
  static Map <String,dynamic> headersOb={HttpHeaders.acceptHeader:"accept: application/json, text/plain, */*"};
}
class HttpService {
      ///请求header的配置
  BuildContext context;
  HttpService(this.context);
  Dio dio =  Dio();
  // ignore: empty_constructor_bodies

  login(data) async{
    return request("/auth/memberlogin?_allow_anonymous=true", data);
  }
  memberGet() async{
    return request("/rest/v1/buyer/get?_allow_anonymous=true",null);
  }

  request(String url,data) async {
    dio.interceptors.add(new TokenInterceptor(context));
    if(url.indexOf("/public")!=-1){
      url= "https://devapi.96101210.com"+url;
    }else if(url.indexOf("/auth")!=-1){
      url= "https://api2.dhfapp.com"+url;
    }else if(url.indexOf("/rest/v1")!=-1){
      // options["headers"]["Authorization"];
      
      _Headers.headersOb["Authorization"] =await dhflocalStore.getToken();
      print("options ${_Headers.headersOb}");

      url = "https://api.dhfapp.com"+url;
    }
    print("url $url");
    Options options = Options(headers:_Headers.headersOb,responseType: ResponseType.json,contentType: "application/x-www-form-urlencoded; charset=UTF-8");
    var result;
    var response ;
    try{
      response = await  dio.post(url,queryParameters: data,options: options);
       if(response.data.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
          result =new Map<String, dynamic>.from(response.data);
       }else if(response.data.runtimeType.toString().indexOf('_InternalLinkedHashMap')!=-1){
          response.data =new Map<String, dynamic>.from(response.data);
       } else if(response.data.runtimeType.toString()=='String'){
        result =json.decode(response.data);
       }
      print("111 ${response.data.runtimeType.toString()}");
    }catch(e){
      print("response ${response}");
      print("33  $e");
    }
    return result;
  }
  
}

// typedef BuildContext ChildContext(BuildContext context);
class TokenInterceptor extends Interceptor{
  BuildContext context;    
  TokenInterceptor(this.context);
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response.statusCode == 401) {
      print("401 .................$context");
      Navigator.pushNamed(context, "/login");
    }
  }
}