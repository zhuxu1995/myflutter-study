import 'package:json_annotation/json_annotation.dart'; 
  
part 'item_pack.g.dart';


@JsonSerializable()
  class itemPack extends Object {

  @JsonKey(name: 'total_count')
  int total_count;

  @JsonKey(name: 'items')
  List<Items> items;

  itemPack(this.total_count,this.items,);

  factory itemPack.fromJson(Map<String, dynamic> srcJson) => _$itemPackFromJson(srcJson);

  Map<String, dynamic> toJson() => _$itemPackToJson(this);

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
  double price;

  @JsonKey(name: 'maket_price')
  double maket_price;

  @JsonKey(name: 'prom_price')
  double prom_price;

  @JsonKey(name: 'packing_fee')
  double packing_fee;

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
  double sku_price;

  @JsonKey(name: 'sku_stocks')
  int sku_stocks;

  @JsonKey(name: 'status_id')
  int status_id;

  @JsonKey(name: 'tax_rate')
  double tax_rate;

  @JsonKey(name: 'xian_gou')
  int xian_gou;

  Skus(this.partner_id,this.store_id,this.sku_id,this.item_id,this.imgurl,this.barcode,this.sku_outer_id,this.sku_properties,this.sku_price,this.sku_stocks,this.status_id,this.tax_rate,this.xian_gou,);

  factory Skus.fromJson(Map<String, dynamic> srcJson) => _$SkusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SkusToJson(this);

}

  
