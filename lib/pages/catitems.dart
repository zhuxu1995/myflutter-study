
import 'package:flutter/material.dart';
import 'package:myappflutter/component/leftCatList.dart';
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
  Itemcats _checked_cat;
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
      child: 
             Row(
              children: <Widget>[
                  LeftCatList(
                    onClick: (Itemcats _currentCat,int i ){
                      print("_currentCat ${_currentCat.name}");
                      setState(() {
                        _checked_cat=_currentCat;
                      });
                    },
                    onInit:(Itemcats _currentCat,int i){
                      setState(() {
                        _checked_cat=_currentCat;
                      });
                    }
                  ),
                  if(_checked_cat!=null&&_checked_cat.cid!=null)
                    new Expanded(
                      child:new Container(
                        key:ValueKey(_checked_cat.cid),
                        child:new ItemScroll(
                          key:ValueKey(_checked_cat.cid),
                          cat:_checked_cat,
                        )
                      ),
                    )
              ],
            ),
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
  int total_count;
  void initState() {
    super.initState();
    itemList=[];
    _cat = widget.cat;
    getCatItem();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==
      _scrollController.position.maxScrollExtent&&total_count>(item_pageNo)*item_pageSize){
        item_pageNo+=1;
        getCatItem();
      }
      
    });
  }
  getCatItem() async{
    var query1 = {"page_no":item_pageNo,"page_size":item_pageSize,"query":{"store_id":1,"category_id":_cat.cid,"on_shelves":1}};
    return httpService.itemPack(query1,nocache:true).then((res){
      if(res["total_count"]>0){
        var items= pubItemPack.fromJson(res);
        setState(() {
          total_count=items.total_count;
          itemList.addAll(items.items_pack);
        });
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      child:ItemListPage(), 
      onRefresh: () async{
        setState(() {
          item_pageNo=1;
          itemList=[];
        });
        getCatItem();
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