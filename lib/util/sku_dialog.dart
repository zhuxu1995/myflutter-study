import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/widgets/button.dart';
import 'package:flutter_vant_kit/widgets/cell.dart';
import 'package:flutter_vant_kit/widgets/stepper.dart';
import 'package:myappflutter/model/skuItem/goods_details_model.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/globalData/sku_provider.dart';
class SkuDialog extends StatefulWidget{

  @override
  _SkuDialog createState() =>new  _SkuDialog();
}
class _SkuDialog extends State<SkuDialog> {
    double maxStock=0,minNum=0,num=0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
          color: Colors.transparent,
          child: Consumer<SkuProvider>(builder: (context, provider, _) {
            return Container(
              color: Colors.white,
              width:width,
              height:900,
              constraints: BoxConstraints(minHeight: 300, maxHeight: 400, maxWidth: double.infinity),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                SizedBox(height: 10),
                _buildInfo(provider,context),
                SizedBox(height: 10),
                SizedBox(
                  height:200.0,
                  child:ListView(children: <Widget>[
                    for (var group in provider.groups)
                      Container(child: 
                        ChangeNotifierProvider<GroupProvider>.value(
                            value: group,
                            child: _RadioGroupItem(),
                        )
                      ,)
                      
                  ]),
                ),
                SizedBox(
                  height:60,
                  child: ChangeNotifierProvider.value(
                    value: provider,
                    child:SkuNumInput() ,
                  )
                ),
                Stack(
                    alignment: Alignment.center,
                    overflow: Overflow.visible,
                    children: <Widget>[

                      Container(
                        width:width,
                        child:Padding(
                          padding: EdgeInsets.only(left:10,right:10),
                          child: ChangeNotifierProvider.value(
                            value: provider,
                            child:NButton(
                              disabled:(provider.selectedSkuModel==null||provider.selectedSkuModel.sku_id==null),
                              text: provider.modalType==1?"????????????":"???????????????",
                              type: "danger",
                              width:200,
                              round:true,
                              onClick: () {
                                if((provider.selectedSkuModel!=null&&provider.selectedSkuModel.sku_id!=null)&&(provider.choiceNum!=null&&provider.choiceNum>0)){
                                  print("????????????${provider.choiceNum}");
                                  var one_sku=  new OrderSkuQueryModel(sku_id: provider.selectedSkuModel.sku_id,sku_num: provider.choiceNum);
                                  var orderSkuPro= OrderSkuProvider();
                                  print("?????????${provider.choiceNum}");
                                  print("??????????????????????????????${provider.modalType.runtimeType}");
                                  if(provider.modalType==1){
                                    orderSkuPro.addSkuQuery(one_sku);
                                    // ChangeNotifierProvider.value(value: orderSkuPro);
                                    Navigator.pushNamed(context, "/order/confirm/index",arguments:{'orderSkuPro':orderSkuPro});
                                    print("XIAORDER ${provider.selectedSkuModel.sku_id}");
                                  }else{
                                    print("???????????????");
                                  }
                                  
                                }
                                
                              },
                            ),
                          ),
                        ),
                      )
                    ]
                )
                
              ]),
            );
          })),
    );
  }

  _buildInfo(SkuProvider provider,BuildContext context) {
    var element;
    if(provider?.selectedSkuModel?.img!=null){
      element=Image.network(provider?.selectedSkuModel?.img);
    }else{
      element=Image.network(provider?.currentItem?.img);
    }
   
    return  Padding(
      padding: EdgeInsets.only(left:10.0,right:10.0,top:0),
      child: 
      // Row(
      //   mainAxisSize: MainAxisSize.max,
      //   children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 0,
                child:Container(
                  child: element,
                  height: 40,
                  width: 40,
                ),
              ),
              // SizedBox(width: 20),
              // Text("?????????${provider?.selectedSkuModel?.count ?? 0}"),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child:Text(provider.selectedSku ?? "?????????"),
              ),
              Expanded(
                flex: 0,
                child:Container(
                height: 20,
                width: 30,
                child:Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -20.0,
                        top: -30,
                        // child:Container(
                        child:IconButton(
                          icon: const Icon(Icons.close,size:18),
                          onPressed: (){
                             Navigator.maybePop(context);
                          },
                        ) 
                          //  CloseButton(),//CloseButton?????????material????????????????????????CloseButton??????????????????Dialog???
                      )
                        
                    ]
                  )
                )
              )
            ],
          ),
        
      //   ],
      // ),
    ) ;
  }
   _choiceSkuNum(SkuProvider provider){
    if(provider?.selectedSkuModel!=null){
      if(provider?.selectedSkuModel?.sku_id!=null){
        // setState((){
          num=1;
          minNum=1;
          maxStock=double.parse(provider.selectedSkuModel.count.toString());
        // });
      }else{
        maxStock=0;minNum=0;num=0;
        // setState((){
          // maxStock=0;minNum=0;num=0;
        // });
      }
      //(provider.selectedSkuModel!=null&&provider.selectedSkuModel.count > 0)?1:0
      return Padding(
        padding: EdgeInsets.only(left:10.0,right:10.0,top:0.0),
        child:Cell(
          title: "????????????",
          customRight: Steppers(
            value:num,
            min: minNum,
            max: maxStock,
            onChange: (val) {
              // Utils.toast(val);
            },
          ),
        ) ,
      );
    }
    
  }  

}

class _RadioGroupItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var group = Provider.of<GroupProvider>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(group.groupName, style: TextStyle(fontSize: 14))),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              for (var radio in group.radios)
                ChangeNotifierProvider<RadioProvider>.value(
                  value: radio,
                  child: _RadioButton(),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var radio = Provider.of<RadioProvider>(context);
    var group = Provider.of<GroupProvider>(context);
    bool isSelect = radio.radioName == group.selectedValue;
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: FlatButton(
        child: Text(radio.radioName, style: TextStyle(fontSize: 12)),
        onPressed: radio.isDisabled
            ? null
            : () {
                if (group.selectedValue != radio.radioName) {
                  //??????
                  group.changeSelectValue(radio.radioName);
                } else {
                  //????????????????????????
                  group.changeSelectValue(null);
                }
              },
        color: isSelect ? Color(0x1AFF6631) : Color(0xFFF7F7F7),
        textColor: isSelect ? Color(0xFFFF6732) : Color(0xff333333),
        disabledTextColor: Color(0xff999999),
        shape: StadiumBorder(
            side: BorderSide(
                style: BorderStyle.solid, color: isSelect ? Color(0xFFFF6732) : Color(0xFFF7F7F7))),
      ),
    );
  }
}
class SkuNumInput extends StatefulWidget{
  @override
  _SkuNumInput createState()=>_SkuNumInput();
  
}
class _SkuNumInput extends State<SkuNumInput>{
  double maxStock=0,minNum=0,skunum=0;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      var SkuP= Provider.of<SkuProvider>(context);
      numInput(order_Number_key){

        return Padding(
          padding: EdgeInsets.only(left:10.0,right:10.0,top:0.0),
          child:Cell(
            title: "????????????",
            customRight: Steppers(
              key:new ValueKey(order_Number_key),
              value:skunum,
              min: minNum,
              max: maxStock,
              onChange: (val) {
                // Utils.toast(val);
                SkuP.addChoiceNum(int.parse(val));
              },
            ),
          ) ,
        );
      }
      if(SkuP.selectedSkuModel!=null){
          if(SkuP?.selectedSkuModel?.sku_id!=null){
              print("???????????????");
              final order_Number_key=SkuP.selectedSkuModel.sku_id;
              if(SkuP.selectedSkuModel.count>0){
                // Future.delayed(Duration(milliseconds: 0)).then((e) {
                //   setState((){
                //     skunum=1;
                //     minNum=1;
                //     maxStock=double.parse(SkuP.selectedSkuModel.count.toString());
                //     SkuP.addChoiceNum(1);
                //   });
                // });
                setState((){
                    skunum=1;
                    minNum=1;
                    maxStock=double.parse(SkuP.selectedSkuModel.count.toString());
                    SkuP.addChoiceNum(1);
                  });
                 return numInput(order_Number_key);
              }else{
                setState((){
                  maxStock=0;minNum=0;skunum=0;
                });
                return numInput(order_Number_key);
              }
              

          }else{
            return Padding(
              padding: EdgeInsets.only(left:10.0,right:10.0,top:0.0),
              child:Cell(
                title: "??????????????????",
              ) ,
            );
          }
      }else{
        return Padding(
          padding: EdgeInsets.only(left:10.0,right:10.0,top:0.0),
          child:Cell(
            title: "??????????????????",
          ) ,
        );
      }
      //(provider.selectedSkuModel!=null&&provider.selectedSkuModel.count > 0)?1:0
      
  }
  
}