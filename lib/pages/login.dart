import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/httpServices/localStore.dart';
class Login extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
 
  FocusScopeNode focusScopeNode;
  GlobalKey _formKey= new GlobalKey<FormState>();
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  HttpService httpservice ;
  DhflocalStore dhflocalStore =new DhflocalStore();
  @override
  Widget build(BuildContext context) {
    httpservice = new HttpService(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              // autovalidate: true, //开启自动校验
              child: Column(
                children: <Widget>[
                  TextFormField(
                      // autofocus: true,
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          icon: Icon(Icons.person)
                      ),
                      // 校验用户名
                      validator: (val) {
                        return val.trim().length > 0 ? null : "用户名不能为空";
                      }

                  ),
                  TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您的登录密码",
                          icon: Icon(Icons.lock)
                      ),
                      obscureText: true, /// 输入变成**
                      //校验密码
                      validator: (val) {
                        return val.trim().length > 5 ? null : "密码不能少于6位";
                      }
                  ),
                  // 登录按钮
                  Container(
                    padding: const EdgeInsets.only(top: 28.0),
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text("登录"),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        /*
                        * 如果：context不对。可以使用GlobalKey，
                        * 通过_formKey.currentState 获取FormState后，
                        * 调用validate()方法校验用户名密码是否合法，校验
                        * 通过后再提交数据。 
                        */
                        if((_formKey.currentState as FormState).validate()){
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                              Map<String,dynamic> data={
                                "mobile":_unameController.text,
                                "password":_pwdController.text,
                                "app_id":"wx82bd84ec09fed74e"
                              };
                              print("Data :$data");
                               httpservice.login(data).then((result){
                                 print("返回结果2：${result}");
                                 print("返回结果：${result['token']}");
                                 if(result['token']==null){
                                   
                                 }else{
                                   
                                    httpservice.memberGet().then((result){

                                    });
                                    dhflocalStore.setToken(result['token']);
                                    // dynamic token =dhflocalStore.getToken();
                                    // print("token: $token");
                                 }
                              });
                              // return Dialog(
                              //   child: Container(
                              //     padding: EdgeInsets.all(22),
                              //     child: Text('提交：' + _unameController.text + '。密码：' + _pwdController.text),
                              //   ),
                              // );
                            // }
                          // );
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}