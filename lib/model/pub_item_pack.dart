import 'package:json_annotation/json_annotation.dart'; 
  
part 'pub_item_pack.g.dart';


@JsonSerializable()
  class pubItemPack extends Object {

  @JsonKey(name: 'total_count')
  int total_count;

  @JsonKey(name: 'items_pack')
  List<Items_pack> items_pack;

  pubItemPack(this.total_count,this.items_pack,);

  factory pubItemPack.fromJson(Map<String, dynamic> srcJson) => _$pubItemPackFromJson(srcJson);

  Map<String, dynamic> toJson() => _$pubItemPackToJson(this);

}

  
@JsonSerializable()
  class Items_pack extends Object {

  @JsonKey(name: 'items')
  Items items;

  @JsonKey(name: 'bargain_rules')
  List<dynamic> bargain_rules;

  @JsonKey(name: 'pin_tuans')
  List<dynamic> pin_tuans;

  Items_pack(this.items,this.bargain_rules,this.pin_tuans,);

  factory Items_pack.fromJson(Map<String, dynamic> srcJson) => _$Items_packFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Items_packToJson(this);

}

  
@JsonSerializable()
  class Items extends Object {

  @JsonKey(name: 'partner_id')
  int partner_id;

  @JsonKey(name: 'store_id')
  int store_id;

  @JsonKey(name: 'p_item_id')
  String p_item_id;

  @JsonKey(name: 'item_id')
  String item_id;

  @JsonKey(name: 'category_id')
  int category_id;

  @JsonKey(name: 'type_id')
  int type_id;

  @JsonKey(name: 'date_related')
  int date_related;

  @JsonKey(name: 'pid')
  int pid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'outer_id')
  String outer_id;

  @JsonKey(name: 'barcode')
  String barcode;

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'img1')
  String img1;

  @JsonKey(name: 'img2')
  String img2;

  @JsonKey(name: 'img3')
  String img3;

  @JsonKey(name: 'img4')
  String img4;

  @JsonKey(name: 'img5')
  String img5;

  @JsonKey(name: 'img6')
  String img6;

  @JsonKey(name: 'img7')
  String img7;

  @JsonKey(name: 'img8')
  String img8;

  @JsonKey(name: 'img9')
  String img9;

  @JsonKey(name: 'cost')
  int cost;

  @JsonKey(name: 'price')
  int price;

  @JsonKey(name: 'maket_price')
  int maket_price;

  @JsonKey(name: 'prom_price')
  double prom_price;

  @JsonKey(name: 'packing_fee')
  int packing_fee;

  @JsonKey(name: 'apply_subs')
  String apply_subs;

  @JsonKey(name: 'limit_pay')
  String limit_pay;

  @JsonKey(name: 'note')
  String note;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'on_shelves')
  int on_shelves;

  @JsonKey(name: 'is_present')
  int is_present;

  @JsonKey(name: 'prom_flag')
  int prom_flag;

  @JsonKey(name: 'is_incl_postage')
  int is_incl_postage;

  @JsonKey(name: 'fare_id')
  int fare_id;

  @JsonKey(name: 'weight')
  int weight;

  @JsonKey(name: 'stock_num')
  int stock_num;

  @JsonKey(name: 'sale_num')
  int sale_num;

  @JsonKey(name: 'delivery_addrs')
  String delivery_addrs;

  @JsonKey(name: 'status_id')
  int status_id;

  @JsonKey(name: 'created_at')
  String created_at;

  @JsonKey(name: 'updated_at')
  String updated_at;

  @JsonKey(name: 'skus')
  List<Skus> skus;

  @JsonKey(name: 'tag_ids')
  String tag_ids;

  @JsonKey(name: 'vdesc')
  String vdesc;

  @JsonKey(name: 'xtype')
  int xtype;

  @JsonKey(name: 'is_virtual')
  bool is_virtual;

  @JsonKey(name: 'sort')
  int sort;

  Items(this.partner_id,this.store_id,this.p_item_id,this.item_id,this.category_id,this.type_id,this.date_related,this.pid,this.title,this.outer_id,this.barcode,this.img,this.img1,this.img2,this.img3,this.img4,this.img5,this.img6,this.img7,this.img8,this.img9,this.cost,this.price,this.maket_price,this.prom_price,this.packing_fee,this.apply_subs,this.limit_pay,this.note,this.description,this.on_shelves,this.is_present,this.prom_flag,this.is_incl_postage,this.fare_id,this.weight,this.stock_num,this.sale_num,this.delivery_addrs,this.status_id,this.created_at,this.updated_at,this.skus,this.tag_ids,this.vdesc,this.xtype,this.is_virtual,this.sort,);

  factory Items.fromJson(Map<String, dynamic> srcJson) => _$ItemsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);

}

  
@JsonSerializable()
  class Skus extends Object {

  @JsonKey(name: 'partner_id')
  int partner_id;

  @JsonKey(name: 'store_id')
  int store_id;

  @JsonKey(name: 'sku_id')
  String sku_id;

  @JsonKey(name: 'item_id')
  String item_id;

  @JsonKey(name: 'imgurl')
  String imgurl;

  @JsonKey(name: 'barcode')
  String barcode;

  @JsonKey(name: 'sku_outer_id')
  String sku_outer_id;

  @JsonKey(name: 'sku_properties')
  String sku_properties;

  @JsonKey(name: 'sku_price')
  int sku_price;

  @JsonKey(name: 'sku_stocks')
  int sku_stocks;

  @JsonKey(name: 'status_id')
  int status_id;

  @JsonKey(name: 'tax_rate')
  int tax_rate;

  @JsonKey(name: 'xian_gou')
  int xian_gou;

  Skus(this.partner_id,this.store_id,this.sku_id,this.item_id,this.imgurl,this.barcode,this.sku_outer_id,this.sku_properties,this.sku_price,this.sku_stocks,this.status_id,this.tax_rate,this.xian_gou,);

  factory Skus.fromJson(Map<String, dynamic> srcJson) => _$SkusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SkusToJson(this);

}

  
