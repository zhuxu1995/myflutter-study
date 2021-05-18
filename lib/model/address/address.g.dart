// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

address _$addressFromJson(Map<String, dynamic> json) {
  return address(
    json['total_count'] as int,
    (json['deliver_addrs'] as List)
        ?.map((e) => e == null
            ? null
            : Deliver_addrs.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$addressToJson(address instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'deliver_addrs': instance.deliver_addrs,
    };

Deliver_addrs _$Deliver_addrsFromJson(Map<String, dynamic> json) {
  return Deliver_addrs(
    json['address_id'] as int,
    json['member_id'] as int,
    json['country'] as String,
    json['province'] as String,
    json['city'] as String,
    json['district'] as String,
    json['address'] as String,
    json['email'] as String,
    json['city_id'] as int,
    json['district_id'] as int,
    json['post_code'] as String,
    json['longitude'] as int,
    json['latitude'] as int,
    json['real_name'] as String,
    json['phone'] as String,
    json['mobile'] as String,
    json['is_default'] as int,
  );
}

Map<String, dynamic> _$Deliver_addrsToJson(Deliver_addrs instance) =>
    <String, dynamic>{
      'address_id': instance.address_id,
      'member_id': instance.member_id,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'address': instance.address,
      'email': instance.email,
      'city_id': instance.city_id,
      'district_id': instance.district_id,
      'post_code': instance.post_code,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'real_name': instance.real_name,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'is_default': instance.is_default,
    };
