import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MemberModel with ChangeNotifier{
  Object member;
  void setMember(Object val){
    this.member = val;
    notifyListeners();
  }
}