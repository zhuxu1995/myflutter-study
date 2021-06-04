// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'areasmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Areasmodel _$AreasmodelFromJson(Map<String, dynamic> json) {
  return Areasmodel(
    json['total_count'] as int,
    (json['areas'] as List)
        ?.map(
            (e) => e == null ? null : Areas.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AreasmodelToJson(Areasmodel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'areas': instance.areas,
    };

Areas _$AreasFromJson(Map<String, dynamic> json) {
  return Areas(
    json['area_id'] as int,
    json['area'] as String,
    json['parent_id'] as int,
  );
}

Map<String, dynamic> _$AreasToJson(Areas instance) => <String, dynamic>{
      'area_id': instance.areaId,
      'area': instance.area,
      'parent_id': instance.parentId,
    };
