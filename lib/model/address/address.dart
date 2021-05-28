import 'package:json_annotation/json_annotation.dart'; 
  
part 'address.g.dart';


@JsonSerializable()
  class address extends Object{

  @JsonKey(name: 'total_count')
  int total_count;

  @JsonKey(name: 'deliver_addrs')
  List<Deliver_addrs> deliver_addrs;

  address(this.total_count,this.deliver_addrs,);

  factory address.fromJson(Map<String, dynamic> srcJson) => _$addressFromJson(srcJson);

}

  
@JsonSerializable()
  class Deliver_addrs extends Object{

  @JsonKey(name: 'address_id')
  int address_id;

  @JsonKey(name: 'member_id')
  int member_id;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'district')
  String district;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'city_id')
  int city_id;

  @JsonKey(name: 'district_id')
  int district_id;

  @JsonKey(name: 'post_code')
  String post_code;

  @JsonKey(name: 'longitude')
  int longitude;

  @JsonKey(name: 'latitude')
  int latitude;

  @JsonKey(name: 'real_name')
  String real_name;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'is_default')
  int is_default;

  Deliver_addrs(this.address_id,this.member_id,this.country,this.province,this.city,this.district,this.address,this.email,this.city_id,this.district_id,this.post_code,this.longitude,this.latitude,this.real_name,this.phone,this.mobile,this.is_default,);

  factory Deliver_addrs.fromJson(Map<String, dynamic> srcJson) => _$Deliver_addrsFromJson(srcJson);
  Map<String,dynamic> toJson()=> _$Deliver_addrsToJson(this);
}

  
