import 'package:json_annotation/json_annotation.dart'; 
  
part 'member_value.g.dart';


@JsonSerializable()
  class memberValue extends Object {

  @JsonKey(name: 'member_id')
  int memberId;

  @JsonKey(name: 'app_id')
  String appId;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'exp')
  int exp;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'birthday')
  String birthday;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'qq')
  String qq;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'reg_from')
  String regFrom;

  @JsonKey(name: 'reg_ip')
  String regIp;

  @JsonKey(name: 'state')
  int state;

  @JsonKey(name: 'reg_time')
  String regTime;

  @JsonKey(name: 'last_login_time')
  String lastLoginTime;

  @JsonKey(name: 'dynamic_token')
  String dynamicToken;

  @JsonKey(name: 'timeout_time')
  int timeoutTime;

  @JsonKey(name: 'client')
  String client;

  @JsonKey(name: 'login_mode')
  int loginMode;

  @JsonKey(name: 'inviter_id')
  int inviterId;

  @JsonKey(name: 'open_id')
  String openId;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'unionid')
  String unionid;

  @JsonKey(name: 'session_key')
  String sessionKey;

  @JsonKey(name: 'privilege')
  String privilege;

  @JsonKey(name: 'is_subscribe')
  bool isSubscribe;

  @JsonKey(name: 'login_store_id')
  int loginStoreId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'level_flag')
  int levelFlag;

  @JsonKey(name: 'id_name')
  String idName;

  @JsonKey(name: 'id_code')
  String idCode;

  memberValue(this.memberId,this.appId,this.userName,this.name,this.exp,this.level,this.sex,this.avatar,this.birthday,this.phone,this.address,this.qq,this.email,this.regFrom,this.regIp,this.state,this.regTime,this.lastLoginTime,this.dynamicToken,this.timeoutTime,this.client,this.loginMode,this.inviterId,this.openId,this.province,this.city,this.country,this.unionid,this.sessionKey,this.privilege,this.isSubscribe,this.loginStoreId,this.remark,this.levelFlag,this.idName,this.idCode,);

  factory memberValue.fromJson(Map<String, dynamic> srcJson) => _$memberValueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$memberValueToJson(this);

}

  
