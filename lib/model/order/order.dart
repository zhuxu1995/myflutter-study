
import 'package:json_annotation/json_annotation.dart'; 
  
part 'order.g.dart';


@JsonSerializable()
  class order extends Object{

  @JsonKey(name: 'order_id')
  String orderId;

  @JsonKey(name: 'app_id')
  String appId;

  @JsonKey(name: 'member_id')
  int memberId;

  @JsonKey(name: 'partner_id')
  int partnerId;

  @JsonKey(name: 'store_id')
  int storeId;

  @JsonKey(name: 'order_from')
  int orderFrom;

  @JsonKey(name: 'order_type')
  int orderType;

  @JsonKey(name: 'fx_ref')
  String fxRef;

  @JsonKey(name: 'mjs_activity_id')
  int mjsActivityId;

  @JsonKey(name: 'mby_activity_id')
  int mbyActivityId;

  @JsonKey(name: 'act_json')
  String actJson;

  @JsonKey(name: 'total_fee')
  double totalFee;

  @JsonKey(name: 'discount_fee')
  double discountFee;

  @JsonKey(name: 'discount_src')
  String discountSrc;

  @JsonKey(name: 'mjs_discount_fee')
  double mjsDiscountFee;

  @JsonKey(name: 'balance_discount')
  int balanceDiscount;

  @JsonKey(name: 'adjust_fee')
  int adjustFee;

  @JsonKey(name: 'post_fee')
  double postFee;

  @JsonKey(name: 'packing_fee')
  int packingFee;

  @JsonKey(name: 'payment')
  double payment;

  @JsonKey(name: 'total_tax')
  double totalTax;

  @JsonKey(name: 'refund_amount')
  int refundAmount;

  @JsonKey(name: 'is_paid')
  int isPaid;

  @JsonKey(name: 'shipping_corp')
  String shippingCorp;

  @JsonKey(name: 'shipping_code')
  String shippingCode;

  @JsonKey(name: 'deliver_name')
  String deliverName;

  @JsonKey(name: 'deliver_phone')
  String deliverPhone;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'district')
  String district;

  @JsonKey(name: 'deliver_address')
  String deliverAddress;

  @JsonKey(name: 'post_code')
  String postCode;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'lock_state')
  int lockState;

  @JsonKey(name: 'evaluation_state')
  int evaluationState;

  @JsonKey(name: 'refund_state')
  int refundState;

  @JsonKey(name: 'pay_way_id')
  int payWayId;

  @JsonKey(name: 'pay_way_code')
  int payWayCode;

  @JsonKey(name: 'pickpoint_id')
  int pickpointId;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'note')
  String note;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'items')
  List<Items> items;

  @JsonKey(name: 'flow_type')
  int flowType;

  @JsonKey(name: 'weight')
  double weight;

  @JsonKey(name: 'food_id')
  String foodId;

  @JsonKey(name: 'coupon_fee')
  double couponFee;

  @JsonKey(name: 'account_json')
  String accountJson;

  @JsonKey(name: 'true_taxes_fee')
  double trueTaxesFee;

  @JsonKey(name: 'profit_status')
  int profitStatus;

  @JsonKey(name: 'flag')
  int flag;

  @JsonKey(name: 'use_integral')
  int useIntegral;

  @JsonKey(name: 'integral_discount')
  double integralDiscount;

  @JsonKey(name: 'active_code')
  String activeCode;

  @JsonKey(name: 'custom_del')
  int customDel;

  @JsonKey(name: 'pick_point_list')
  List<int> pickPointList;

  @JsonKey(name: 'err_msg')
  String errMsg;

  @JsonKey(name: 'idName')
  String idName;

  @JsonKey(name: 'idCard')
  String idCard;

  order(this.orderId,this.appId,this.memberId,this.partnerId,this.storeId,this.orderFrom,this.orderType,this.fxRef,this.mjsActivityId,this.mbyActivityId,this.actJson,this.totalFee,this.discountFee,this.discountSrc,this.mjsDiscountFee,this.balanceDiscount,this.adjustFee,this.postFee,this.packingFee,this.payment,this.totalTax,this.refundAmount,this.isPaid,this.shippingCorp,this.shippingCode,this.deliverName,this.deliverPhone,this.email,this.country,this.province,this.city,this.district,this.deliverAddress,this.postCode,this.status,this.lockState,this.evaluationState,this.refundState,this.payWayId,this.payWayCode,this.pickpointId,this.userId,this.note,this.remark,this.items,this.flowType,this.weight,this.foodId,this.couponFee,this.accountJson,this.trueTaxesFee,this.profitStatus,this.flag,this.useIntegral,this.integralDiscount,this.activeCode,this.customDel,this.pickPointList,this.errMsg,this.idName,this.idCard,);

  factory order.fromJson(Map<String, dynamic> srcJson) => _$orderFromJson(srcJson);
  Map<String, dynamic> toJson() => _$orderToJson(this);
}

  
@JsonSerializable()
  class Items extends Object {

  @JsonKey(name: 'order_item_id')
  int orderItemId;

  @JsonKey(name: 'order_id')
  String orderId;

  @JsonKey(name: 'item_id')
  String itemId;

  @JsonKey(name: 'sku_id')
  String skuId;

  @JsonKey(name: 'outer_id')
  String outerId;

  @JsonKey(name: 'sku_outer_id')
  String skuOuterId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'sku_properties')
  String skuProperties;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'sku_stocks')
  int skuStocks;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'total_fee')
  double totalFee;

  @JsonKey(name: 'discount_fee')
  double discountFee;

  @JsonKey(name: 'discount_src')
  String discountSrc;

  @JsonKey(name: 'packing_fee')
  double packingFee;

  @JsonKey(name: 'payment')
  double payment;

  @JsonKey(name: 'item_tax')
  double itemTax;

  @JsonKey(name: 'limit_pay')
  String limitPay;

  @JsonKey(name: 'activity_id')
  int activityId;

  @JsonKey(name: 'bargain_act_id')
  int bargainActId;

  @JsonKey(name: 'pintuan_id')
  int pintuanId;

  @JsonKey(name: 'pintuan_activity_id')
  int pintuanActivityId;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'act_json')
  String actJson;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'delivery_addrs')
  String deliveryAddrs;

  @JsonKey(name: 'weight')
  double weight;

  @JsonKey(name: 'barcode')
  String barcode;

  @JsonKey(name: 'xtype')
  int xtype;

  @JsonKey(name: 'is_virtual')
  bool isVirtual;

  @JsonKey(name: 'true_taxes_fee')
  double trueTaxesFee;

  @JsonKey(name: 'refund_state')
  int refundState;

  @JsonKey(name: 'refund_amount')
  int refundAmount;

  Items(this.orderItemId,this.orderId,this.itemId,this.skuId,this.outerId,this.skuOuterId,this.title,this.skuProperties,this.image,this.quantity,this.skuStocks,this.price,this.totalFee,this.discountFee,this.discountSrc,this.packingFee,this.payment,this.itemTax,this.limitPay,this.activityId,this.bargainActId,this.pintuanId,this.pintuanActivityId,this.startDate,this.endDate,this.actJson,this.updatedAt,this.deliveryAddrs,this.weight,this.barcode,this.xtype,this.isVirtual,this.trueTaxesFee,this.refundState,this.refundAmount,);

  factory Items.fromJson(Map<String, dynamic> srcJson) => _$ItemsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

  
