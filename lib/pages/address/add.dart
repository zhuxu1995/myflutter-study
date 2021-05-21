import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vant_kit/main.dart';
import 'package:flutter_vant_kit/widgets/cellGroup.dart';
import 'package:myappflutter/component/pickerView.dart';

class AddressPageAdd extends StatelessWidget{
  // ignore: missing_return
  var address_id;
  var address_info;
  @override
  Widget build(BuildContext context){
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;
    if(router_arguments!=null&&router_arguments.isNotEmpty&&router_arguments['address_id']!=null){
      address_id = router_arguments['address_id'];
    }
    return Scaffold(
      appBar: AppBar(),
      body:new AddressAddForm(),
    );
  }
  
}
class AddressAddForm extends StatefulWidget{
  var address_id;
  var address_info;
  @override
  _AddressAddForm createState() =>_AddressAddForm();
  AddressAddForm({this.address_id,this.address_info});
  
}
class _AddressAddForm extends State<AddressAddForm>{
  @override
  var _id;
  Map input = {
    "name": TextEditingController(),
    "tel": TextEditingController(),
    "area": TextEditingController(),
    "addressDetail": TextEditingController(),
    "postalCode": TextEditingController(),
  };
  bool setDefaultAddress = false;
  // List<WePickerItem> options2 = [
  //   WePickerItem(label:"广东省",value: "100101"),
  //     WePickerItem("深圳市", child: [
  //       WePickerItem("南山区"),
  //       WePickerItem("福田区"),
  //       WePickerItem("龙岗区"),
  //       WePickerItem("宝安区"),
  //       WePickerItem("罗湖区"),
  //     ])
  //   ])
  // ];
  List<PickerItem> options = [
    PickerItem("广东省", child: [
      PickerItem("广州市", child: [
        PickerItem("天河区"),
        PickerItem("萝岗区"),
        PickerItem("荔湾区"),
        PickerItem("番禺区"),
        PickerItem("白云区"),
      ]),
      PickerItem("深圳市", child: [
        PickerItem("南山区"),
        PickerItem("福田区"),
        PickerItem("龙岗区"),
        PickerItem("宝安区"),
        PickerItem("罗湖区"),
      ])
    ])
  ];
  List<int> _cityId = [];
  Map<String, dynamic> _addressInfo;
  void initState() {
    super.initState();
    _id = widget.address_id;
    _addressInfo = widget.address_info ?? {};
    List areas = [];
    (_addressInfo ?? {}).forEach((key, value) {
      if (["province", "city", "county"].contains(key) && value != null)
        areas.add(value);
      if (["provinceId", "cityId", "countyId"].contains(key)){
        _cityId.add(value ?? 0);
        print("val ${value}");
      }
      if (["name", "tel", "addressDetail", "postalCode"].contains(key) &&
          value != null) input[key].text = value;
    });
    input['area'].text = areas.join('/');
    super.initState();
    
  }
  Widget buildNameField(){
    return Field(
      label: "姓名",
      placeholder: "收货人姓名",
      controller: input['name'],
    );
  }
  Widget buildPhoneField() {
    return Field(
      label: "手机号",
      placeholder: "收货人手机号",
      controller: input['tel'],
      keyboardType: TextInputType.phone,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(11)
      ],
    );
  }
  Widget buildAreaField() {
    return Field(
      label: "地区",
      placeholder: "省/市/区 选择",
      rightIcon: Icons.chevron_right,
      controller: input['area'],
      readonly: true,
      onClick: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Picker(
                colums: options,
                level: 3,
                defaultIndex: [0,0,0],
                showToolbar: true,
                onConfirm: (values, index) {
                  setState(() {
                    input['area'].text = values.join('/');
                    _cityId = index;
                  });
                  Navigator.of(context).pop();
                },
                onCancel: (values, index) {
                  Navigator.of(context).pop();
                },
                onChange:(values, index){
                  print("${values.toString()}");
                }
              );
            });
      },
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CellGroup(
            border: false,
            children: <Widget>[
              buildNameField(),
              buildPhoneField(),
              buildAreaField(),
              // WePickerView(
              //   options:options,
              // ),
            ],
        ),
      ],
    );
  }

}