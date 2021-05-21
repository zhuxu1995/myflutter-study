import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vant_kit/main.dart';
import 'package:myappflutter/component/sku.dart';
import 'package:myappflutter/httpServices/httpService.dart';

class ItemInfo extends StatefulWidget{
  @override
  _ItemInfo createState()=> _ItemInfo();
}
class _ItemInfo extends State<ItemInfo>{
  HttpService httpService =new HttpService();

  @override
  getItem(itemId) async{
    return httpService.itemPackOne(itemId).then((res){
        return res;
    });
  }
  getItemDetail(itemId,cb){
    return new FutureBuilder(
      future: getItem(itemId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot){
        return cb(Map<String, dynamic>.from(asyncSnapshot.data));
      }
    );
  }
  void addOrder(){
      print("立即购买");
  }
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // TODO: implement build
    Map<String,dynamic> router_arguments=ModalRoute.of(context).settings.arguments;
    var item_id;
        return Scaffold(
          body:getItemDetail(router_arguments['item_id'],(result){
            var item;
            // print("result ${result['items_pack']}");
            if(result['items_pack'].length>0){
              item=List.from(result['items_pack'])[0]['items'];
            }
            // print("iteminfo ${item}");
            if(item!=null&&item['item_id']!=null){
              List <Image> images=[];
              if(item['img']!=null){
                // print("img ${item['img']}");
                images.add(Image.network(item['img'],fit: BoxFit.fitWidth));
              }
              if(item['img1']!=null&&item['img1']!=''){
                images.add(Image.network(item['img1'],fit:BoxFit.fitWidth));
              }
              if(item['img2']!=null&&item['img1']!=''){
                images.add(Image.network(item['img2'],fit:BoxFit.fitWidth));
              }
              if(item['img3']!=null&&item['img1']!=''){
                images.add(Image.network(item['img3'],fit:BoxFit.fitWidth));
              }
              if(item['img4']!=null&&item['img1']!=''){
                images.add(Image.network(item['img4'],fit:BoxFit.fitWidth));
              }
              if(item['price']!=null&&item['price']>=0){
                // item['price']=Double();
              }
              return Column(
                children:[
                  Container(
                    height:(height-60),
                    child:ListView(
                        children: [
                          AspectRatio(
                            aspectRatio: 16.0 / 9.0,
                            child: Swiper(
                              indicatorAlignment: AlignmentDirectional.bottomEnd,
                              speed: 0,
                              reverse :false,
                              autoStart: false,
                              circular: true,
                              indicator: NumberSwiperIndicator(),
                              children:images,
                            ),
                          ),
                          Container(
                            child:Row(
                              children: [
                                Price(value: item['price'].toDouble())
                              ],
                            ),
                            padding: EdgeInsets.only(left:10.0,right:10.0),
                          ),
                          Container(
                            child:Text(item['title']),
                            padding: EdgeInsets.only(left:10.0,right:10.0),
                          ),
                        ],
                    )
                  ),
                  Container(
                    height:60,
                    child:Stack(
                      children:[
                        Positioned(
                          width:width,
                          left:0,
                          bottom:0,
                          child: GoodsAction(
                            actions: [
                              ActionButtonItem(text: "客服", icon: Icons.chat_bubble_outline),
                              ActionButtonItem(text: "购物车", icon: Icons.add_shopping_cart),
                            ],
                            buttons: [
                              ButtonItem(
                                  text: "加入购物车",
                                  color: LinearGradient(
                                      colors: [Color(0xffffd01e), Color(0xffff8917)]),
                                  onClick: (){
                                    print("加入购物车");
                                    new Sku(context).initItem(item['item_id'],0);
                                  }       
                              ),
                              ButtonItem(
                                  text: "立即购买",
                                  color: LinearGradient(colors: [Color(0xffff6034), Color(0xffee0a24)]),
                                  onClick: (){
                                    new Sku(context).initItem(item['item_id'],1);
                                      // ActionSheet(
                                      //   child: Container(
                                      //     height:600,
                                      //     color: Colors.blue,
                                      //   ),
                                      //   round :false,
                                      //   // title:"222",
                                      //   closeIcon: Icons.highlight_off,
                                      // ).show(context);
                           
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return BottomSheet(
                                    //       onClosing: (){},
                                    //       builder: (context) {
                                    //           return Container(
                                    //             height: 6000,
                                    //             color: Colors.amber,
                                    //             child: Column(
                                    //               children: <Widget>[
                                    //                 ButtonBar(
                                    //                   children: <Widget>[
                                    //                     CloseButton()
                                    //                   ],
                                    //                 ),
                                    //                 Text('这是BottomSheet'),
                                    //                 Text('他没有遮罩层'),
                                    //                 Text('也不会自动下去'),
                                    //                 Text('使用时还需要 _scaffoldkey.currentState'),
                                    //               ],
                                    //             ),
                                    //           );
                                    //       },
                                    //     );
                                    //   }
                                    // ); 
                                  }
                              ),
                                  
                            ],
                          ),
                        )
                      ]
                    )
                  )
                
                ]
               

              );
            }
            
          })
    );
  }
}
// class ItemContent extends {
//   @override 
//   Widget build(){

//   }
// }
class NumberSwiperIndicator extends SwiperIndicator{
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.only(top: 10.0,right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 2.0),
      child: Text("${++index}/$itemCount", style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}