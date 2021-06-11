// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

itemPack _$itemPackFromJson(Map<String, dynamic> json) {
  return itemPack(
    json['total_count'] as int,
    (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Items.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$itemPackToJson(itemPack instance) => <String, dynamic>{
      'total_count': instance.total_count,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    json['partner_id'] as int,
    json['store_id'] as int,
    json['p_item_id'] as String,
    json['item_id'] as String,
    json['category_id'] as int,
    json['type_id'] as int,
    json['date_related'] as int,
    json['pid'] as int,
    json['title'] as String,
    json['outer_id'] as String,
    json['barcode'] as String,
    json['img'] as String,
    json['img1'] as String,
    json['img2'] as String,
    json['img3'] as String,
    json['img4'] as String,
    json['img5'] as String,
    json['img6'] as String,
    json['img7'] as String,
    json['img8'] as String,
    json['img9'] as String,
    json['cost'] as int,
    (json['price'] as num)?.toDouble(),
    (json['maket_price'] as num)?.toDouble(),
    (json['prom_price'] as num)?.toDouble(),
    (json['packing_fee'] as num)?.toDouble(),
    json['apply_subs'] as String,
    json['limit_pay'] as String,
    json['note'] as String,
    json['description'] as String,
    json['on_shelves'] as int,
    json['is_present'] as int,
    json['prom_flag'] as int,
    json['is_incl_postage'] as int,
    json['fare_id'] as int,
    json['weight'] as int,
    json['stock_num'] as int,
    json['sale_num'] as int,
    json['delivery_addrs'] as String,
    json['status_id'] as int,
    json['created_at'] as String,
    json['updated_at'] as String,
    (json['skus'] as List)
        ?.map(
            (e) => e == null ? null : Skus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['tag_ids'] as String,
    json['vdesc'] as String,
    json['xtype'] as int,
    json['is_virtual'] as bool,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'partner_id': instance.partner_id,
      'store_id': instance.store_id,
      'p_item_id': instance.p_item_id,
      'item_id': instance.item_id,
      'category_id': instance.category_id,
      'type_id': instance.type_id,
      'date_related': instance.date_related,
      'pid': instance.pid,
      'title': instance.title,
      'outer_id': instance.outer_id,
      'barcode': instance.barcode,
      'img': instance.img,
      'img1': instance.img1,
      'img2': instance.img2,
      'img3': instance.img3,
      'img4': instance.img4,
      'img5': instance.img5,
      'img6': instance.img6,
      'img7': instance.img7,
      'img8': instance.img8,
      'img9': instance.img9,
      'cost': instance.cost,
      'price': instance.price,
      'maket_price': instance.maket_price,
      'prom_price': instance.prom_price,
      'packing_fee': instance.packing_fee,
      'apply_subs': instance.apply_subs,
      'limit_pay': instance.limit_pay,
      'note': instance.note,
      'description': instance.description,
      'on_shelves': instance.on_shelves,
      'is_present': instance.is_present,
      'prom_flag': instance.prom_flag,
      'is_incl_postage': instance.is_incl_postage,
      'fare_id': instance.fare_id,
      'weight': instance.weight,
      'stock_num': instance.stock_num,
      'sale_num': instance.sale_num,
      'delivery_addrs': instance.delivery_addrs,
      'status_id': instance.status_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'skus': instance.skus,
      'tag_ids': instance.tag_ids,
      'vdesc': instance.vdesc,
      'xtype': instance.xtype,
      'is_virtual': instance.is_virtual,
      'sort': instance.sort,
    };

Skus _$SkusFromJson(Map<String, dynamic> json) {
  print("1${json['sku_stocks'].runtimeType}");
  return Skus(
    json['partner_id'] as int,
    json['store_id'] as int,
    json['sku_id'] as String,
    json['item_id'] as String,
    json['imgurl'] as String,
    json['barcode'] as String,
    json['sku_outer_id'] as String,
    json['sku_properties'] as String,
    (json['sku_price'] as num)?.toDouble(),
    json['sku_stocks'] as int,
    json['status_id'] as int,
    (json['tax_rate'] as num)?.toDouble(),
    json['xian_gou'] as int,
  );
}

Map<String, dynamic> _$SkusToJson(Skus instance) => <String, dynamic>{
      'partner_id': instance.partner_id,
      'store_id': instance.store_id,
      'sku_id': instance.sku_id,
      'item_id': instance.item_id,
      'imgurl': instance.imgurl,
      'barcode': instance.barcode,
      'sku_outer_id': instance.sku_outer_id,
      'sku_properties': instance.sku_properties,
      'sku_price': instance.sku_price,
      'sku_stocks': instance.sku_stocks,
      'status_id': instance.status_id,
      'tax_rate': instance.tax_rate,
      'xian_gou': instance.xian_gou,
    };
