import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myappflutter/globalData/app.dart';
import 'dart:io';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:myappflutter/main.dart';
import 'package:myappflutter/globalData/member.dart';
import 'package:myappflutter/model/item_pack.dart';
import 'package:myappflutter/model/member/member_value.dart';
import 'package:myappflutter/model/pub_item_pack.dart';
import 'package:provider/provider.dart';

class _Headers  {
  static Map <String,dynamic> headersOb={HttpHeaders.acceptHeader:"accept: application/json, text/plain, */*"};
}
class HttpServiceFu{
  HttpServiceFu();
}
class HttpService extends HttpServiceFu{
      ///请求header的配置
  BuildContext context;
  Dio dio =  Dio();
  DhflocalStore dhflocalStore;
  HttpService(){
     dhflocalStore=new DhflocalStore();
  }

  //小程序配置
  wxAppConfigGet(data){
    
    return request('/public/wxappcfg/get', data);
  }
  //省市区查询
  areaGet(data) {
      return request('/public/area/get', data);
  }
  //收货地址查询
  addressGet(data) async{
    return request("/rest/v1/address/get", data);
  }
  //收货地址查询
  addressAdd(data) async{
    if(data.isNotEmpty&&data.runtimeType.toString()!='String'){
      // data=jsonEncode(data);
    }
    return request("/rest/v1/address/add", data);
  }
  //修改售后地址
  addressUpdate(data) {
        data = data ?? {};
        return request("/rest/v1/address/update", data);
  }
  //下单
  confirmOrder(data) {
        return request("/rest/v1/order/confirm/add", data);
  }
  // ignore: empty_constructor_bodies
  previewOrder(data) async{
    if(data["buy_para"].isNotEmpty&&data['buy_para'].runtimeType.toString()!='String'){
        data["buy_para"] =jsonEncode(data["buy_para"]);
    }
    return request("/rest/v1/order/preview/add", data);
  }
  catGet(data) async{
    return request("/public/category/get", data);
  }
  login(data) async{
    return request("/auth/memberlogin?_allow_anonymous=true", data);
  }
  memberGet() async{
    var data={
      "_allow_anonymous":true
    };
    return request("/rest/v1/buyer/get?_allow_anonymous=true",data).then((result){
      return result;
    });
  }
  itemOneGet(item_id) async{
      var query = {
          "query": {
              "item_id": item_id
          }
      };
      return itemGet(query).then((res) {
          var item;
          var result= new pubItemPack.fromJson(res);
          // var res1 =new  itemPack.fromJson(res);
          if (result.total_count>=1) {
              item = result.items_pack[0].items;
          }
          return item;
      });
  }
  itemGet(data)async {
      return request("/public/itempack/get?_allow_anonymous=true", data);
  }
  itemPack(data,{nocache=false}) async{
    print("nocache ${nocache}");
    return request("/rest/v1/itempack/get",data,dayNum:nocache?0:1).then((result){
       if(result.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
          result =new Map<String, dynamic>.from(result);
       }else if(result.runtimeType.toString().indexOf('_InternalLinkedHashMap')!=-1){
          result =new Map<String, dynamic>.from(result);
       }
      return result;
    });
  }
  itemPackOne(itemId) async{
    return itemPack({"query":{"item_id":itemId}},nocache:true).then((result){
       if(result.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
          result =new Map<String, dynamic>.from(result);
       }else if(result.runtimeType.toString().indexOf('_InternalLinkedHashMap')!=-1){
          result =new Map<String, dynamic>.from(result);
       }
      return result;
    });
  }
  formDataUpdate(data) {
        return this.requestPhpApi2("dhf.customform.formupdate", data, 600);
  }
  formDataAdd(data) {
        return this.requestPhpApi2("dhf.customform.formadd", data, 600);
  }
  formGet(data) async{
        return  requestPhpApi2("dhf.customform.formget", data, 600);
  }
  requestPhpApi2(
      String  method,
        content,
        ttl,
        {isnotToken}
    ) async{
        var data = { "method": method, "content": content };
        if (data["content"]!=null&&data["content"].runtimeType.toString()!='String') {
            data["content"] = jsonEncode(content);
        }
        var path = "/api2/rest/";
        // if (isnotToken.isEmpty) {
        //     // path += "?_allow_anonymous=true";
        // }
        return request(path, data, dayNum:ttl);
  }
  request(String url,data,{int dayNum=0}) async {
    
    dio.interceptors.add(new TokenInterceptor());
    // var config ;
    Map<String,dynamic>configJson;
    App _app = Provider.of<App>(context,listen: false);
    try{
      Future<String> loadConfigJson() async {
        return rootBundle.loadString('assets/config/config.json');
      }
      if(_app.config.isEmpty){
        configJson =jsonDecode(await loadConfigJson());
        _app.setConfig(configJson);
      }
     
    }catch(e){

    }
    // print("request入口");
    // config=json.decode(config);
    // print("config ${configJson.runtimeType}");
    // print("config ${configJson['api']}");
    if(url.indexOf("/public")!=-1){
      // url= "https://api.dhfapp.com"+url;
       url= _app.config['api']+url;
    }else if(url.indexOf("/auth")!=-1){
       url= _app.config['api2']+url;
      //  url= "http://localhost:4040"+url;
    }else if(url.indexOf("/rest/v1")!=-1|| url.indexOf('/api2') != -1){
      var token =await dhflocalStore.getToken();
      if(token==null){
        BuildContext context = navigatorKey.currentState.overlay.context;  
        Navigator.pushNamed(context, "/login");
      }else{
        _Headers.headersOb["Authorization"]=token;
      }
      print("options2 ${_Headers.headersOb}");
      if(url.indexOf("/rest/v1")!=-1){
                url= _app.config['api']+url;

            }else{
                url= _app.config['api2']+url;
            }
        
    }
    if(data.runtimeType.toString()!="String"){
     data= new Map<String, dynamic>.from(data);
    }
    if(data.runtimeType.toString()!="String"&&data['query']!=null&&data['query'].isNotEmpty){
       var queryTmp = [];
      //  print("data22 ${ data['query']}");
      //  print("data33 ${ data['query'].runtimeType}");
       data['query'].forEach((key,val){
         var str=key + ":" + val.toString();
         queryTmp.add(str);
       });
       data['query']=queryTmp.join(",");
    }
    print("url $url");
    // var data1=FormData.fromMap(data);
    // print("${data1}");
    // print("data1 type ${data1.runtimeType}");
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: url,defaultMaxAge:Duration(days: dayNum))).interceptor);

    Options options = Options(headers:_Headers.headersOb,responseType: ResponseType.json,contentType: "application/x-www-form-urlencoded; charset=UTF-8");
    var result;
    var response ;
    
    try{
      print("data ${json.encode(data)}");
      print("dayNum ${dayNum}");

      response = await  dio.post(url,data: data,options:buildCacheOptions(
        Duration(days: dayNum), 
        maxStale: Duration(days: dayNum), 
        options:options,
        subKey:json.encode(data),
        forceRefresh: (dayNum==0)
	    ));
       if(response.data.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
          result =new Map<String, dynamic>.from(response.data);
          // result=response.data;
       }else if(response.data.runtimeType.toString().indexOf('_InternalLinkedHashMap')!=-1){
          // result=response.data;
          response.data =new Map<String, dynamic>.from(response.data);
       } else if(response.data.runtimeType.toString()=='String'){
        result =json.decode(response.data);
       } else {
         result = response.data;
       }
        if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        // data come from cache
          print("缓存 ${url}");
        } else {
            // data come from net
          print("网络请求 ${url}");
        }
      //  print("prin ${result}");
    }catch(e){
      // print("http $e");
    }
    return result;
  }
  
}

// typedef BuildContext ChildContext(BuildContext context);
class TokenInterceptor extends Interceptor{
  BuildContext context = navigatorKey.currentState.overlay.context;   
  TokenInterceptor();
  //  context = navigatorKey.currentState.overlay.context;
  // @override
  // void onRequest(RequestOptions options,RequestInterceptorHandler handler) async{
  //   try{

  //   }catch(e){
      
  //   }
  // }
  // ,RequestInterceptorHandler handler
  @override
  Future onRequest(RequestOptions options) async{
    try{

      super.onRequest(options);
    }catch(e){
      
    }
  }
  // ,ErrorInterceptorHandler handler
  Future onError(DioError err) async{
    try{
      // print("eer ${err}");
      if (err.response != null && err.response.statusCode == 401) {
           TokenStatus tokenStatus = Provider.of<TokenStatus>(context,listen: false);
          var isTokenStatus=tokenStatus.isTokenGuoQi;
            if(isTokenStatus==null||isTokenStatus==false){
              Provider.of<TokenStatus>(context,listen:false).setTokenGuoQi(true);
              Navigator.pushNamed(context, "/login").then((member){
                if(member!=null){
                  var curMember= memberValue.fromJson(member);
                  Provider.of<TokenStatus>(context,listen:false).setTokenGuoQi(false);
                }else{
                  Provider.of<TokenStatus>(context,listen:false).setTokenGuoQi(false);
                }
              });
            }
        
        
        // TokenStatus tokenStatus = Provider.of<TokenStatus>(context);
        // var isTokenStatus=tokenStatus.isTokenGuoQi;
        // print("|4444444444 ${err}");
        // 
        super.onError(err);
        return err;
      }
    }catch(e){

    }
    
  }
}