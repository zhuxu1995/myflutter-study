import 'package:flutter/material.dart';


class GoodsDetailsModel {
  List<SkuModel> skus;
  List<Goods> goods;

  GoodsDetailsModel({this.skus, this.goods});

  GoodsDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['skus'] != null) {
      skus = new List<SkuModel>();
      json['skus'].forEach((v) {
        skus.add(new SkuModel.fromJson(v));
      });
    }
    if (json['goods'] != null) {
      goods = new List<Goods>();
      json['goods'].forEach((v) {
        goods.add(new Goods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.skus != null) {
      data['skus'] = this.skus.map((v) => v.toJson()).toList();
    }
    if (this.goods != null) {
      data['goods'] = this.goods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Goods {
  String name;
  List<String> items;

  Goods({this.name, this.items});

  Goods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['items'] = this.items;
    return data;
  }
}

class SkuModel {
  String img;
  double price;
  int count;
  String sku;
  String sku_id;

  SkuModel({this.img, this.price, this.count, this.sku,this.sku_id});

  SkuModel.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    price = json['price'];
    count = json['count'];
    sku = json['sku'];
    sku_id = json['sku_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['price'] = this.price;
    data['count'] = this.count;
    data['sku'] = this.sku;
    data['sku_id'] = this.sku_id;
    return data;
  }
}

class OrderSkuQueryModel{
  // ignore: non_constant_identifier_names
  String sku_id;
  // ignore: non_constant_identifier_names
  int sku_num;
  // ignore: non_constant_identifier_names
  OrderSkuQueryModel({this.sku_id, this.sku_num});
  OrderSkuQueryModel.fromJson(Map<String, dynamic> json) {
    sku_id = json['sku_id'];
    sku_num = json['sku_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku_id'] = this.sku_id;
    data['sku_num'] = this.sku_num;
    return data;
  }
}