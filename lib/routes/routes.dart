
import 'package:flutter_vant_kit/main.dart';
import 'package:myappflutter/component/footerTabBar.dart';
import 'package:myappflutter/pages/address/add.dart';
import 'package:myappflutter/pages/address/list.dart';
import 'package:myappflutter/pages/item/itemInfo.dart';
import 'package:myappflutter/pages/login.dart';
import 'package:myappflutter/pages/my_member.dart';
import 'package:myappflutter/pages/new_page.dart';
import 'package:myappflutter/main.dart';
import 'package:myappflutter/pages/order/confirm.dart';
class MyRoutes{
  static List get routes_list => [
    {
      "name":"基础页",
      "route":{
        "/login":(context) => Login(),
        "/goods/detail/index":(context)=>ItemInfo(),
        "/order/confirm/index":(context)=>ConfirmOrder(),
        "/address/list/index":(context)=>AddressListPage(),
        "/address/add/index":(context)=>AddressPageAdd(),
      }
    },
  ];
}