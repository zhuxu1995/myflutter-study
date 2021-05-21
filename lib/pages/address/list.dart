import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/addressList.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/address/address.dart';
class AddressListPage extends StatelessWidget{
  Widget build(BuildContext context) {
  print("进入收货地址列表页");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址"),
      ),
      body: AddressGetPage()
    );
  }
}
class AddressGetPage extends StatefulWidget{
  _AddressGetPage createState()=> new  _AddressGetPage();
}
class _AddressGetPage extends State<AddressGetPage>{
  HttpService httpService =new HttpService();
  address address_list ;
  addressGet() {
    httpService.addressGet({}).then((result){
      print("address list ${result.toString()}");
      if(result!=null&&result.isNotEmpty){
        setState(() {
          address_list=address.fromJson(result); 
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    print("列表实例页");
    // TODO: implement build
    if(address_list==null){
      addressGet();
      return Container();
    }else{
      print("address_list ${address_list.deliver_addrs.toString()}");
    }
    return new Container(
        child:new AddressList(
          switchable: true,
          list: [
            if(address_list!=null&&address_list.deliver_addrs.isNotEmpty)
              for(var adressObj in address_list.deliver_addrs)
                AddressInfoId(
                addressId:adressObj.address_id.toString(),
                name:adressObj.real_name,
                tel:adressObj.phone,
                province:adressObj.province,
                city:adressObj.city,
                cityId: adressObj.city_id,
                county: adressObj.district,
                countyId: adressObj.district_id,
                addressDetail: adressObj.address,
                isDefault: adressObj.is_default==0?false:true
              )
          ],
          onSelect: (selectAddressInfo ,index){
            var info= selectAddressInfo as AddressInfoId;//类型转换
            print("选择地址id ${info.addressId}");
          },
          onEdit: (edAddressInfo,int index){
            var info= edAddressInfo as AddressInfoId;//类型转换
            print("选择地址id ${info.addressId}");
          },
          onAdd: (){
            print("进入创建地址页");
             Navigator.pushNamed(context, "/address/add/index");
          },
        ),
    );
  }
}
class AddressInfoId extends AddressInfo{
  final String addressId;
  final String name;
  final String tel;
  final String province;
  final String city;
  final String county;
  final int provinceId;
  final int cityId;
  final int countyId;
  final String addressDetail;
  final String postalCode;
  final bool isDefault;
  AddressInfoId({this.addressId,this.name,
      this.tel,
      this.province,
      this.city,
      this.county,
      this.provinceId,
      this.cityId,
      this.countyId,
      this.addressDetail,
      this.postalCode,
      this.isDefault});
}