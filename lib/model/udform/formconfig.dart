import 'package:json_annotation/json_annotation.dart'; 
  
part 'formconfig.g.dart';


@JsonSerializable()
  class formconfig extends Object {

  @JsonKey(name: 'Msg')
  String Msg;

  @JsonKey(name: 'form_options')
  List<Form_options> form_options;

  formconfig(this.Msg,this.form_options,);

  factory formconfig.fromJson(Map<String, dynamic> srcJson) => _$formconfigFromJson(srcJson);
  Map<String,dynamic> toJson()=>_$formconfigToJson(this);
}

  
@JsonSerializable()
  class Form_options extends Object {

  @JsonKey(name: 'type_id')
  String type_id;

  @JsonKey(name: 'store_id')
  String store_id;

  @JsonKey(name: 'partner_id')
  String partner_id;

  @JsonKey(name: 'form_id')
  String form_id;

  @JsonKey(name: 'sort')
  String sort;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'title_msg')
  String title_msg;

  @JsonKey(name: 'options')
  String options;

  @JsonKey(name: 'default_value')
  String default_value;

  @JsonKey(name: 'is_must')
  String is_must;

  @JsonKey(name: 'display')
  String display;

  @JsonKey(name: 'status')
  String status;

  Form_options(this.type_id,this.store_id,this.partner_id,this.form_id,this.sort,this.type,this.title,this.title_msg,this.options,this.default_value,this.is_must,this.display,this.status,);

  factory Form_options.fromJson(Map<String, dynamic> srcJson) => _$Form_optionsFromJson(srcJson);
  Map<String, dynamic> toJSon()=>_$Form_optionsToJson(this);
}

  
