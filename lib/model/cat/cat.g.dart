// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$catFromJson(Map<String, dynamic> json) {
  return Cat(
    json['total_count'] as int,
    (json['itemcats'] as List)
        ?.map((e) =>
            e == null ? null : Itemcats.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$catToJson(Cat instance) => <String, dynamic>{
      'total_count': instance.totalCount,
      'itemcats': instance.itemcats,
    };

Itemcats _$ItemcatsFromJson(Map<String, dynamic> json) {
  return Itemcats(
    json['partner_id'] as int,
    json['store_id'] as int,
    json['cid'] as int,
    json['parent_cid'] as int,
    json['name'] as String,
    json['level'] as int,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$ItemcatsToJson(Itemcats instance) => <String, dynamic>{
      'partner_id': instance.partnerId,
      'store_id': instance.storeId,
      'cid': instance.cid,
      'parent_cid': instance.parentCid,
      'name': instance.name,
      'level': instance.level,
      'sort': instance.sort,
    };
