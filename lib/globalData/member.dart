import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
class MemberModel with ChangeNotifier{
  Object member;
  @override
  
  void setMember(val)async {
    this.member = val;
    //通知
    // notifyListeners();
  }
  getMember(){
    return member;
  }
}
class TokenStatus with ChangeNotifier{
  bool isTokenGuoQi=false;//过期状态判断跳转登录
  void setTokenGuoQi(val)async {
    this.isTokenGuoQi = val;
    //通知
    // notifyListeners();
    // 
  }
  bool getStates(){
    return this.isTokenGuoQi;
  }
}