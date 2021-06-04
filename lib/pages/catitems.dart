
import 'package:flutter/material.dart';
import 'package:myappflutter/helper/hexColor.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/cat/cat.dart';
import 'package:myappflutter/model/order/order.dart';
import 'package:myappflutter/model/pub_item_pack.dart';
class SideCatViewMenu extends StatefulWidget{
  @override
  _SideCatViewMenu createState() => _SideCatViewMenu();
}
class _SideCatViewMenu extends State<SideCatViewMenu>{
  List<dynamic> cat_list,items;
  var cat_list_new;
  HttpService httpService =new HttpService();
  // ListText({Key key,@required this.items}) :super(key: key);
  int pageNo=1,pageSize=100;
  int _selectedIdx=0;
  final _menuHeight = 50.0;
  final _menuWidth = 100.0;
  getCatList() async{
    var query1 = {"page_no":pageNo,"page_size":pageSize,"query":{"store_id":1}};
    return httpService.catGet(query1).then((res){
        return res;
    });
  }
  int item_pageNo=1,item_pageSize=10;
  getCatItem(cat_id) async{
    var query1 = {"page_no":item_pageNo,"page_size":item_pageSize,"query":{"store_id":1,"category_id":cat_id,"on_shelves":1}};
    return httpService.itemPack(query1).then((res){
        return res;
    });
  }
  @override 
  Widget build(BuildContext context){
    return Container(
      child: new FutureBuilder(
        future:getCatList(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
          Map<String,dynamic> result;
          if(snapshot.data!=null){
            result=new Map<String, dynamic>.from(snapshot.data);
          }
          if(result!=null&&result.isNotEmpty){
            cat_list = result["itemcats"];
            cat_list_new=Cat.fromJson(result);
          }else{
            return Container();
          }
          if(cat_list!=null&&cat_list.length>0){
            return Row(
              children: <Widget>[
                  
                  new Container(
                    width: _menuWidth,
                    child:new ListView.builder(
                      itemCount: cat_list.length,
                      itemBuilder: (context, index){
                        cat_list[index]= new Map<String, dynamic>.from(cat_list[index]);
                        var str = cat_list[index]['name'];
                        return  GestureDetector(
                          onTap: (){
                            setState((){
                              item_pageNo=1;
                              _selectedIdx = index;
                            });
                          },
                          child: Column(
                            children:[
                              Container(
                                height:_menuHeight,
                                color: (_selectedIdx == index)
                              ? Colors.white 
                              : HexColor("#F1F1F1"),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 5,
                                      height: _menuHeight,
                                      color: (_selectedIdx == index)
                                          ? HexColor("#40a9eb")
                                          : HexColor("#F1F1F1"),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(str),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                          ),
                        );
                        // return ListTile(
                        //   title: new Text("${items[index]['name']}",style:TextStyle(backgroundColor:Colors.blue),),
                        // );
                      },
                    )
                  ),
                  // Expanded(
                  //   child: Container(
                  //     child: FutureBuilder(
                  //       future: getCatItem(cat_list[_selectedIdx]['cid']),
                  //       builder:(BuildContext context, AsyncSnapshot<dynamic> item_snapshot){
                  //         if(item_snapshot.data!=null){
                  //           Map<String,dynamic> item_pack_result=new Map<String, dynamic>.from(item_snapshot.data);
                  //           if(item_pack_result.isNotEmpty){
                  //             items = item_pack_result["items_pack"];
                  //           }
                  //           if(items.length>0){
                  //             return RefreshIndicator(
                  //               child: new ListView.builder(
                  //                 itemCount: items.length,
                  //                 itemBuilder: (context, index){
                  //                   items[index]= new Map<String, dynamic>.from(items[index]);
                  //                   if(items[index]["item"]!=null){
                  //                   items[index]["item"]= new Map<String, dynamic>.from(items[index]["item"]);
                  //                   }
                  //                   if(items[index]['items']!=null){
                  //                     return GestureDetector(
                  //                       key: ValueKey(items[index]["items"]['item_id']),
                  //                       child:new Container(
                  //                         key: ValueKey(items[index]["items"]['item_id']),
                  //                         child:new Row(
                  //                           children: [
                  //                             new  Image.network(items[index]["items"]['img'],width: 60.0),
                  //                             new Expanded(
                  //                               flex:1,
                  //                               child:new Padding(
                  //                                 padding: EdgeInsets.only(left:10.0,bottom:10.0,right:10.0),
                  //                                 child: new Column(
                  //                                   children:[
                  //                                     new Container(
                  //                                       child: new Text(items[index]["items"]["title"],textAlign:TextAlign.left,overflow:TextOverflow.ellipsis,maxLines: 1,),
                  //                                       alignment: Alignment.topLeft,
                  //                                     ),
                  //                                     new Container(
                  //                                       child:new Text("¥"+items[index]["items"]["price"].toString(),style:TextStyle(color:HexColor("#ff0000"))),
                  //                                       alignment: Alignment.topLeft,
                  //                                     )
                  //                                   ],
                  //                                   mainAxisAlignment:MainAxisAlignment.start,
                  //                                 ),
                  //                               ) 
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         height:60.0,
                  //                         padding:EdgeInsets.only(bottom:10.0)
                  //                       ),
                  //                       onTap:(){
                  //                         print("点击商品");
                  //                         Navigator.pushNamed(context, "/goods/detail/index",arguments:{'item_id':items[index]['items']['item_id']});
                  //                       },
                  //                     );
                                    
                  //                   }
                                    
                  //                 }
                  //               ), 
                  //               onRefresh: (){
                  //                 item_pageNo=1;
                  //                 return getCatItem(cat_list[_selectedIdx]['cid']).then((item_result){
                  //                   // print("item_result ${item_result.toString()}");
                  //                   if(item_result!=null&&item_result.isNotEmpty){
                  //                     setState(() {
                  //                       items = item_result["items_pack"];
                  //                     });
                  //                   }
                  //                 });
                  //               }
                  //             );
                  //           }
                  //         }else{
                  //           return Container();
                  //         }
                          
                  //       }
                  //     )
                  //   ),
                  // ),
                  
                  new Expanded(
                    child:new Container(
                      key:ValueKey(cat_list_new.itemcats[_selectedIdx].cid),
                      child:new ItemScroll(
                        key:ValueKey(cat_list_new.itemcats[_selectedIdx].cid),
                        cat:cat_list_new.itemcats[_selectedIdx],
                      )
                  ),
                  )
              ],
            ) ;
          }
          
        } ,
        ) 
    );
  }
}
class ItemScroll extends StatefulWidget{
  Key key;
  Itemcats  cat;
  ItemScroll({
    Key key,
    this.cat,
  }):super(key: key);
  @override
  _ItemScrollPage createState() => _ItemScrollPage();
}
class  _ItemScrollPage  extends State<ItemScroll>{
  Key _key;
  Itemcats _cat;
  List<Items_pack> itemList=[];
  //滚动控制器
  ScrollController _scrollController =new ScrollController();
  HttpService httpService=new HttpService();
  int item_pageNo=1,item_pageSize=10;
  void initState() {
    super.initState();
    print("商品列表");
    itemList=[];
    _cat = widget.cat;
    getCatItem();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==
      _scrollController.position.maxScrollExtent){
        item_pageNo+=1;
        getCatItem();
      }
      
    });
    print("catid ${_cat.cid}");
  }
  getCatItem() async{
    var query1 = {"page_no":item_pageNo,"page_size":item_pageSize,"query":{"store_id":1,"category_id":_cat.cid,"on_shelves":1}};
    return httpService.itemPack(query1).then((res){
      var items= pubItemPack.fromJson(res);
      setState(() {
        itemList.addAll(items.items_pack);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      child:ItemListPage(), 
      onRefresh: (){
        item_pageNo=1;
        print("下拉刷新");
      }
    );
  }
  Widget ItemListPage(){
    return new ListView.builder(
      key:ValueKey(_cat.cid),
      itemCount: itemList.length,
      itemBuilder:(context, i)=>ItemPage(i),
      controller: _scrollController,
    );
  }
  Widget ItemPage(int i){
    print("${itemList[i].items.item_id}");
    return  GestureDetector(
      key: ValueKey(itemList[i].items.item_id),
      child:new Container(
        key: ValueKey(itemList[i].items.item_id),
        child:new Row(
          children: [
            new  Image.network(itemList[i].items.img,width: 60.0),
            new Expanded(
              flex:1,
              child:new Padding(
                padding: EdgeInsets.only(left:10.0,bottom:10.0,right:10.0),
                child: new Column(
                  children:[
                    new Container(
                      child: new Text(itemList[i].items.title,textAlign:TextAlign.left,overflow:TextOverflow.ellipsis,maxLines: 1,),
                      alignment: Alignment.topLeft,
                    ),
                    new Container(
                      child:new Text("¥"+itemList[i].items.price.toString(),style:TextStyle(color:HexColor("#ff0000"))),
                      alignment: Alignment.topLeft,
                    )
                  ],
                  mainAxisAlignment:MainAxisAlignment.start,
                ),
              ) 
            ),
          ],
        ),
        height:60.0,
        padding:EdgeInsets.only(bottom:10.0)
      ),
      onTap:(){
        print("点击商品");
        Navigator.pushNamed(context, "/goods/detail/index",arguments:{'item_id':itemList[i].items.item_id});
      },
    );
  }
}