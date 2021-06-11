import 'package:flutter/material.dart';
import 'package:myappflutter/helper/hexColor.dart';
import 'package:myappflutter/httpServices/httpService.dart';
import 'package:myappflutter/model/cat/cat.dart';
//左侧分类导航栏
class LeftCatList extends StatefulWidget{
  @override
  Key key;
  // ignore: non_constant_identifier_names
  final String store_id;
  final double width;
  final Function(Itemcats cat,int index) onClick;
  final Function(Itemcats cat,int index) onInit;
  LeftCatList({
    Key key, 
    this.store_id,
    this.width,
    this.onInit,
    this.onClick}) : super(key: key);
  
  _LeftCatList createState() => _LeftCatList();
}
class _LeftCatList extends State<LeftCatList>{
  // ignore: unused_field
  HttpService httpService;
  String _storeId;
  int pageNo=1,pageSize=10;
  List<Itemcats> catList=[];
  int cat_total_count=0;
  int _selectedIdx=0;
  double _menuWidth=100.00;
  double _menuHeight = 50.0;
  // ignore: non_constant_identifier_names
  // ignore: unused_field
  ScrollController _scrollController =new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService=HttpService();
    if(widget.store_id!=null&&widget.store_id.isNotEmpty){
      _storeId = widget.store_id;
    }
    if(widget.width!=null&&!widget.width.isNaN){
      _menuWidth= widget.width;
    }
    getCatList().then((result){
      var catObj =Cat.fromJson(result);
      catList= catObj.itemcats;
      cat_total_count= catObj.totalCount;
      if(widget.onInit!=null)widget.onInit(catList[0],0);
    });
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==
      _scrollController.position.maxScrollExtent&&cat_total_count>(pageNo)*pageSize){
        pageNo+=1;
        getCatList();
      }
      
    });
  }
  getCatList() async{
    var query1 = {"page_no":pageNo,"page_size":pageSize,"query":{"store_id":1}};
    return httpService.catGet(query1).then((res){
        setState(() {
          if(pageNo==1){
            var catObj =Cat.fromJson(res);
            catList= catObj.itemcats;
            cat_total_count= catObj.totalCount;
          }else{
            var catObj =Cat.fromJson(res);
            catList.addAll(catObj.itemcats);
            cat_total_count= catObj.totalCount;
          }
          
        });
        return res;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: _menuWidth,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: catList.length,
        itemBuilder: (context, index){
          var str = catList[index].name;
          return GestureDetector(
            onTap: (){
              if (widget.onClick!= null)widget.onClick(catList[index],index);
              setState((){
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
        }
      ),
    );
  }
  
}