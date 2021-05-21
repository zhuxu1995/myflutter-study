import 'package:flutter/material.dart';
import 'package:myappflutter/model/udform/formconfig.dart';

class FormOptionsProvider with ChangeNotifier{
  List<Form_options> form_options=[];
  void addForm(form){
    this.form_options.add(form);
    notifyListeners();
  }
  void addFormList(list){
    this.form_options=list;
    notifyListeners();
  }
}