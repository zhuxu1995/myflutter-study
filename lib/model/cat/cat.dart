import 'package:json_annotation/json_annotation.dart'; 
  
part 'cat.g.dart';


@JsonSerializable()
  class Cat extends Object {

  @JsonKey(name: 'total_count')
  int totalCount;

  @JsonKey(name: 'itemcats')
  List<Itemcats> itemcats;

  Cat(this.totalCount,this.itemcats,);

  factory Cat.fromJson(Map<String, dynamic> srcJson) => _$CatFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CatToJson(this);

}

  
@JsonSerializable()
  class Itemcats extends Object {

  @JsonKey(name: 'partner_id')
  int partnerId;

  @JsonKey(name: 'store_id')
  int storeId;

  @JsonKey(name: 'cid')
  int cid;

  @JsonKey(name: 'parent_cid')
  int parentCid;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'sort')
  int sort;

  Itemcats(this.partnerId,this.storeId,this.cid,this.parentCid,this.name,this.level,this.sort,);

  factory Itemcats.fromJson(Map<String, dynamic> srcJson) => _$ItemcatsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemcatsToJson(this);

}

  
