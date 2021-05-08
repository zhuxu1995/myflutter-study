import 'package:flutter/material.dart';
import 'package:myappflutter/httpServices/localStore.dart';
import 'package:provider/provider.dart';
import 'package:myappflutter/globalData/member.dart';
import 'package:myappflutter/httpServices/httpService.dart';
DhflocalStore dhflocalStore =new DhflocalStore();
 

class MyMember extends StatefulWidget{
  @override
  MyMemberNew createState() => new MyMemberNew();
}
tokenGet(context) async{
      dynamic result= await dhflocalStore.getToken();
      HttpService httpService= new HttpService();
      dynamic member;
      if(result!=null){
        try{
          member= await  dhflocalStore.getCurrentUserInfo();
          // member = await httpService.memberGet();
        }catch(e){
          
        }
      }else{
        // Navigator.pushNamed(context, "/login");
      }
      return member;
}
class MyMemberNew extends State<MyMember>{
  @override
  Widget build(BuildContext context) {
  MemberModel member_model = Provider.of<MemberModel>(context);  
    return Scaffold(
      body:FutureBuilder(
        future:tokenGet(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done ){
            print("fff ${snapshot.data}");
            if(snapshot.data!=null){
              Provider.of<MemberModel>(context).setMember(snapshot.data);
              // member_model.setMember(snapshot.data);
            }
          } 
          return MemberAvatar();
        },
      ),
    );
  }
}
class MemberAvatar extends StatefulWidget{
  @override
  _MemberAvatar createState()=> new _MemberAvatar();
}
class _MemberAvatar extends State<MemberAvatar>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // MemberModel member_model = Provider.of<MemberModel>(context);  
    // print("name ${member_model.member}");
    return new Container(
      child: new Padding(
        padding: EdgeInsets.only(left: 10.0,top:15.0,right: 10.0,bottom: 15.0),
        child: Row(
          children: [
            new Avatar(),
            new AvatarMemberTools()
          ],
        ),
      ),
      color: Colors.black54,
    ); 
  }
}
class Avatar extends Container{
  Image avatarImg = Image.asset("assets/images/avatar.png",width: 40.0);
  
   void setAvatar(path){
    if(path){

    }else{
      avatarImg = Image.asset("assets/images/avatar.png",width: 40.0);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MemberModel member_model = Provider.of<MemberModel>(context);  
    Map<String,dynamic> member =member_model.member;
    if(member.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
      member =new Map<String, dynamic>.from(member);
    }
    print("member build ${member.runtimeType.toString()}");
    String path ;
    if(member!=null&&member.isNotEmpty){
      path=member["avatar"];
    }
    if(path!=null){
      avatarImg = Image.network(path,width: 40.0);
    }else{
      avatarImg = Image.asset("assets/images/avatar.png",width: 40.0);
    }
    return Container(
      child: avatarImg,
      width:40.0,
      height:40.0,
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
    );
  }
}

class AvatarMemberTools extends StatefulWidget{
  @override
  _AvatarMemberTools createState()=> new _AvatarMemberTools();
}

class _AvatarMemberTools extends State<AvatarMemberTools>{
  @override
  Widget build(BuildContext context) {
    MemberModel member_model = Provider.of<MemberModel>(context);  
    Map<String,dynamic> member =member_model.member;
    if(member.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
      member =new Map<String, dynamic>.from(member);
    }
    // TODO: implement build
    return new Container(
      child: Column(
        children: [
          new Row(
            children: [
             Denlgu(),
            ],
          ),
          new Row(
            children:[
              Jifen()
            ],
          ),
        ],
        crossAxisAlignment:CrossAxisAlignment.start
      ),
      height:40.0,
      padding:EdgeInsets.only(left:10.0,),
    );
  }
}
class Denlgu extends StatefulWidget{
  @override
  _Denlgu createState()=> new _Denlgu();
  
}
class _Denlgu extends State<Denlgu>{
    @override
    Widget build(BuildContext context) {
      MemberModel member_model = Provider.of<MemberModel>(context);  
      Map<String,dynamic> member =member_model.member;
      if(member.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
        member =new Map<String, dynamic>.from(member);
      }
      String title;
      if(member!=null&&member.isNotEmpty){
        title=member["name"];
      }else{
        title="登陆";
      }
      // TODO: implement build
      return GestureDetector(
        child:new Text(title,
          style:TextStyle(
              // backgroundColor: Colors.redAccent,
              fontSize: 12.0
          )
        ),
        onTap: (){
          if(member==null||!member.isNotEmpty){
            Navigator.pushNamed(context, "/login");
          }
        },
      );
    }
  }
  class Jifen extends StatefulWidget {
    @override
    _Jifen createState()=> _Jifen();
  }
  class _Jifen extends State<Jifen>{
    @override
    
    Widget build(BuildContext context) {
      MemberModel member_model = Provider.of<MemberModel>(context);  
      Map<String,dynamic> member =member_model.member;
      if(member!=null&&member.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>"){
        member =new Map<String, dynamic>.from(member);
      }
      print("jifen $member");
      // TODO: implement build
      String jifen;
      print("member ${member}");
      if(member!=null&&member.length!=0&&member.isNotEmpty){
        jifen=member["level"].toString();
      }else{
        jifen="";
      }
      return new Container(
        child: Text(jifen,
            style:TextStyle(
                color: Colors.black,
                fontSize: 10.0
            )
        )
      );
    }
  }