import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:myappflutter/main.dart';
import 'package:myappflutter/model/member.dart';
import 'package:provider/provider.dart';
DhflocalStore dhflocalStore =new DhflocalStore();
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
  
  // ignore: empty_constructor_bodies
  
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
          res =Map<String,dynamic>.from(res);
          if (res['total_count']>=1) {
              item = res['items_pack'][0]['items'];
          }
          return item;
      });
  }
  itemGet(data)async {
      return request("/public/itempack/get?_allow_anonymous=true", data);
  }
  itemPack(data) async{
    return request("/rest/v1/itempack/get",data).then((result){
      return result;
    });
  }
  itemPackOne(itemId) async{
    return itemPack({"query":{"item_id":itemId}}).then((result){
      return result;
    });
  }
  request(String url,data) async {
    
    dio.interceptors.add(new TokenInterceptor());
    print("request入口");
    var config =await rootBundle.loadString('assets/config/config.json');
    Map<String,dynamic>configJson= jsonDecode(config);
    // config=json.decode(config);
    print("config ${configJson.runtimeType}");
    print("config ${configJson['api']}");
    if(url.indexOf("/public")!=-1){
      // url= "https://api.dhfapp.com"+url;
       url= configJson['api']+url;
    }else if(url.indexOf("/auth")!=-1){
       url= configJson['api2']+url;
      //  url= "http://localhost:4040"+url;
    }else if(url.indexOf("/rest/v1")!=-1){
      // options["headers"]["Authorization"];
      
      _Headers.headersOb["Authorization"] =await dhflocalStore.getToken();
      if(_Headers.headersOb["Authorization"]==null){
        BuildContext context = navigatorKey.currentState.overlay.context;  
        Navigator.pushNamed(context, "/login");
      }
      print("options2 ${_Headers.headersOb}");
        url= configJson['api']+url;
    }
    data= new Map<String, dynamic>.from(data);
    if(data['query']!=null&&data['query'].isNotEmpty){
       var queryTmp = [];
       print("data ${data.runtimeType}");
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
    Options options = Options(headers:_Headers.headersOb,responseType: ResponseType.json,contentType: "application/x-www-form-urlencoded; charset=UTF-8");
    var result;
    var response ;
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   print("2233");
    //   print("client $client");
    //   // config the http client
    //   client.findProxy = (uri) {
    //     //proxy all request to localhost:8888
    //     return 'PROXY localhost:8888';
    //   };
    //   client.badCertificateCallback =
    //     (X509Certificate cert, String host, int port) => true;
    //   // you can also create a HttpClient to dio
    //   // return HttpClient();
    // };

    try{
      print("data ${data}");
      response = await  dio.post(url,data: data,options: options);
       if(response.data.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
          result =new Map<String, dynamic>.from(response.data);
       }else if(response.data.runtimeType.toString().indexOf('_InternalLinkedHashMap')!=-1){
          response.data =new Map<String, dynamic>.from(response.data);
       } else if(response.data.runtimeType.toString()=='String'){
        result =json.decode(response.data);
       } else {
         result = response.data;
       }
      //  print("prin ${result}");
    }catch(e){
      print("http $e");
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
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    try{
      print("eer ${err}");
      if (err.response != null && err.response.statusCode == 401) {
        print("401 .................");
        try{
           TokenStatus tokenStatus = Provider.of<TokenStatus>(context,listen: false);
          var isTokenStatus=tokenStatus.isTokenGuoQi;
          print("|99999999999999");
            print("isToken ${isTokenStatus}");
            if(isTokenStatus==null||isTokenStatus==false){
              Provider.of<TokenStatus>(context,listen:false).setTokenGuoQi(true);
              Navigator.pushNamed(context, "/login");
            }
        }catch(e){
          print("MemberModel ${e}");
        }
        
        // TokenStatus tokenStatus = Provider.of<TokenStatus>(context);
        // var isTokenStatus=tokenStatus.isTokenGuoQi;
        
        // 
        // 
        super.onError(err,handler);
      }
    }catch(e){

    }
    
  }
}