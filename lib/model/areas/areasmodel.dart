import 'package:json_annotation/json_annotation.dart'; 
  
part 'areasmodel.g.dart';


@JsonSerializable()
  class areasmodel extends Object{

  @JsonKey(name: 'total_count')
  int totalCount;

  @JsonKey(name: 'areas')
  List<Areas> areas;

  areasmodel(this.totalCount,this.areas,);

  factory areasmodel.fromJson(Map<String, dynamic> srcJson) => _$areasmodelFromJson(srcJson);

}

  
@JsonSerializable()
  class Areas extends Object{

  @JsonKey(name: 'area_id')
  int areaId;

  @JsonKey(name: 'area')
  String area;

  @JsonKey(name: 'parent_id')
  int parentId;

  Areas(this.areaId,this.area,this.parentId,);

  factory Areas.fromJson(Map<String, dynamic> srcJson) => _$AreasFromJson(srcJson);

}

  
